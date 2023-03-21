include("mcts_single.jl")

file_name = "sp_F_20221217"

function Environments.reward(env::InvertedPendulumEnv)
    x = env.state.y[1]
    thetas = env.state.y[3:2:end]
    is_far = (
        x < -env.opts.x_threshold / 2 ||
        x > env.opts.x_threshold / 2 ||
        any(thetas .< -env.opts.theta_threshold_radians / 2) ||
        any(thetas .> env.opts.theta_threshold_radians / 2)
    )
    println("Inside reward and $is_far")
    if is_far
        0.5
    else
        1.0
    end
end

opts = PendulumOpts()
envfun = () -> InvertedPendulumEnv(opts)


full_budget = round.(Int, exp10.(range(1, 5, 81)))
full_budget = full_budget[(full_budget.>=30)]

b = single_pendulum_batch(seed_shift = 1:10, planner_file_name = nothing)
execute_batch(b, file_name, envfun = envfun, show_progress = true, start_new_file = true)
