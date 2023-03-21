include("mcts_single.jl")

file_name = "sp_H_20221219"
max_steps = 500
Environments.reward(env::InvertedPendulumEnv) =
    reward_discrete_1_and_0_5(env::InvertedPendulumEnv)

opts = PendulumOpts(max_steps = max_steps)
envfun = () -> InvertedPendulumEnv(opts)

b = single_pendulum_batch(seed_shift = 1:10, planner_file_name = nothing)
execute_batch(b, file_name, envfun = envfun, show_progress = true, start_new_file = true)
