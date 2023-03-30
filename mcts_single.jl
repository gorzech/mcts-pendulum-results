using LinearAlgebra
using MKL
# BLAS.set_num_threads(1)
using Environments
import Environments: reward
using PureMCTS

function execute_batch_single_args(args; file_name, max_force = 10.0, max_steps = 200)
    cmd_args = parse_args(args)
    b = single_pendulum_batch(command_args = cmd_args)

    opts = PendulumOpts(max_steps = max_steps)
    data =
        Environments.PendulumData(9.81, 1.0, 0.1, 1.1, 0.5, 0.05, max_force, 0.02, "euler")
    envfun = () -> InvertedPendulumEnv(data, opts)

    batch_file_name = get_batch_file_name(file_name, command_args = cmd_args)
    println("Save results to $batch_file_name")


    execute_batch(
        b,
        batch_file_name,
        envfun = envfun,
        show_progress = true,
        start_new_file = true,
        file_dump_interval = 100,
    )
end

Base.@kwdef struct CommandArgs
    seed_shift_start::Int = 1
    seed_shift_end::Int = 10
    planner_file_name::Union{String,Vector{String}, Nothing} = nothing
end

parse_args(args) = try
    try_parse_args(args)
catch
    print_arguments_explaination()
    rethrow()
end

function try_parse_args(args)
    if length(args) == 0
        CommandArgs()
    elseif length(args) == 1
        if tryparse(Int, args[1]) === nothing
            CommandArgs(planner_file_name = args[1])
        else
            seed_shift_start = parse(Int, args[1])
            CommandArgs(seed_shift_start = seed_shift_start, seed_shift_end = seed_shift_start)
        end
    elseif length(args) == 2
        seed_shift_start = parse(Int, args[1])
        if tryparse(Int, args[2]) === nothing
            CommandArgs(seed_shift_start = seed_shift_start, seed_shift_end = seed_shift_start, planner_file_name = args[2])
        else
            CommandArgs(seed_shift_start = seed_shift_start, seed_shift_end = parse(Int, args[2]))
        end
    else
        seed_shift_start = parse(Int, args[1])
        seed_shift_end = parse(Int, args[2])
        CommandArgs(seed_shift_start = seed_shift_start, seed_shift_end = seed_shift_end, planner_file_name = args[3:end])
    end
end

function print_arguments_explaination()
    println(
        """All arguments are optional. Multiple arguments can be provided. Those are 
[seed_shift_start, [seed_shift_end, [existing_file_names...]]]
By default seed_shift_start = 1, seed_shift_end = 10, and existing_file_name is empty.
If many file names are provided it is required to provide both seed shifts as well.""",
    )
    nothing
end

get_batch_file_name(file_name; command_args::CommandArgs) =
    "$(file_name)_$(command_args.seed_shift_start)_$(command_args.seed_shift_end)"

function single_pendulum_batch(; command_args::CommandArgs)
    full_budget = round.(Int, exp10.(range(1, 5, 81)))
    full_budget = full_budget[(full_budget.>=30)]

    return planner_batch(
        budget = full_budget,
        horizon = 4:30,
        γ = 0.5:0.05:1.0,
        exploration_param = [0, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024],
        seed_shift = command_args.seed_shift_start:command_args.seed_shift_end,
        file_name = command_args.planner_file_name,
    )
end

function reward_discrete_1_and_0_5(env::InvertedPendulumEnv)
    x = env.state.y[1]
    thetas = env.state.y[3:2:end]
    is_far = (
        x < -env.opts.x_threshold / 2 ||
        x > env.opts.x_threshold / 2 ||
        any(thetas .< -env.opts.theta_threshold_radians / 2) ||
        any(thetas .> env.opts.theta_threshold_radians / 2)
    )
    if is_far
        0.5
    else
        1.0
    end
end

function reward_cart_angle_use_exp(
    env::InvertedPendulumEnv;
    cart_share = 0.0,
    angle_share = 1.0,
    cart_dispersion_factor = 0.25,
    angle_dispersion_factor = 0.25,
)
    x = env.state.y[1]
    θ = env.state.y[3]
    cart_reward = exp(-(x / env.opts.x_threshold / cart_dispersion_factor)^2)
    angle_reward = exp(-(θ / env.opts.theta_threshold_radians / angle_dispersion_factor)^2)
    return cart_share * cart_reward + angle_share * angle_reward
end

function reward_cart_angle_penalty(
    env::InvertedPendulumEnv;
    cart_penalty_share = 0.5,
    angle_penalty_share = 0.5,
    cart_penalty_power = 1.0,
    angle_penalty_power = 1.0,
)
    x = env.state.y[1]
    θ = env.state.y[3]
    cart_penalty = abs(x / env.opts.x_threshold)^cart_penalty_power
    angle_penalty = abs(θ / env.opts.theta_threshold_radians)^angle_penalty_power
    return 1.0 - cart_penalty_share * cart_penalty - angle_penalty_share * angle_penalty
end

reward_angle_penalty(env::InvertedPendulumEnv) =
    1.0 - abs(env.state.y[3]) / env.opts.theta_threshold_radians

function reward_tip_penalty(
    env::InvertedPendulumEnv;
    x_tip_threshold = 0.5,
    y_tip_threshold = 0.5,
)
    x = env.state.y[1]
    θ = env.state.y[3]
    l = 2 * env.data.length
    x_tip = x - l * sin(θ)
    y_tip_largest_drop = l * (1 - cos(env.opts.theta_threshold_radians))
    y_tip_drop = l * (1 - cos(θ))
    return 1.0 - x_tip_threshold * abs(x_tip) / env.opts.x_threshold -
           y_tip_threshold * y_tip_drop / y_tip_largest_drop
end

function reward_tip_penalty_use_exp(
    env::InvertedPendulumEnv;
    x_share = 0.0,
    y_share = 1.0,
    x_dispersion_factor = 0.25,
    y_dispersion_factor = 0.25,
)
    x = env.state.y[1]
    θ = env.state.y[3]
    l = 2 * env.data.length
    x_tip = x - l * sin(θ)
    y_tip_largest_drop = l * (1 - cos(env.opts.theta_threshold_radians))
    y_tip_drop = l * (1 - cos(θ))
    x_reward = exp(-(abs(x_tip) / env.opts.x_threshold / x_dispersion_factor)^2)
    y_reward = exp(-(y_tip_drop / y_tip_largest_drop / y_dispersion_factor)^2)
    return x_share * x_reward + y_share * y_reward
end

function check_reward_here_and_there(reward_function)
    env = InvertedPendulumEnv()
    reset!(env)

    for x in LinRange(-env.opts.x_threshold, env.opts.x_threshold, 5)
        println("Displacement x = $x")
        for θ in
            LinRange(-env.opts.theta_threshold_radians, env.opts.theta_threshold_radians, 5)
            env.state.y = [x, 0.0, θ, 0.0]
            print("$θ: $(reward_function(env)), ")
        end
        println("")
    end
end