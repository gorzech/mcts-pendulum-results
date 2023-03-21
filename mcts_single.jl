using LinearAlgebra
using MKL
# BLAS.set_num_threads(1)
using Environments
import Environments: reward
using PureMCTS

seed_shoft_from_args(args) =
    if length(args) == 1
        s12 = parse(Int, args[1])
        s12:s12
    elseif length(args) == 2
        s1 = parse(Int, args[1])
        s2 = parse(Int, args[2])
        s1:s2
    elseif length(args) == 0
        1:10
    else
        throw(
            ArgumentError(
                "Incorrect number of arguments. Got $(length(args)), expected 0 to 2",
            ),
        )
    end

get_batch_file_name(file_name; seed_shift) =
    "$(file_name)_$(seed_shift[1])_$(seed_shift[end])"

function single_pendulum_batch(; seed_shift, planner_file_name)
    full_budget = round.(Int, exp10.(range(1, 5, 81)))
    full_budget = full_budget[(full_budget.>=30)]

    return planner_batch(
        budget = full_budget,
        horizon = 4:30,
        γ = 0.5:0.05:1.0,
        exploration_param = [0, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024],
        seed_shift = seed_shift,
        file_name = planner_file_name,
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

function reward_cart_angle_penalty(
    env::InvertedPendulumEnv;
    cart_penalty_share = 0.5,
    angle_penalty_share = 0.5,
)
    x = env.state.y[1]
    θ = env.state.y[3]
    return 1.0 - cart_penalty_share * abs(x) / env.opts.x_threshold -
           angle_penalty_share * abs(θ) / env.opts.theta_threshold_radians
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
    y_tip_lowest = l * cos(env.opts.theta_threshold_radians)
    y_tip = l * cos(θ)
    return 1.0 - x_tip_threshold * abs(x_tip) / env.opts.x_threshold -
           y_tip_threshold * (1 - y_tip) / (1 - y_tip_lowest)
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