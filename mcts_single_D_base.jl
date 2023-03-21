include("mcts_single.jl")

file_name = "sp_D_20221122"

opts = PendulumOpts()
envfun = () -> InvertedPendulumEnv(opts)

b = single_pendulum_batch(seed_shift = 1:10, planner_file_name = nothing)
execute_batch(b[1:10], file_name, envfun = envfun, show_progress = true, start_new_file = true)
