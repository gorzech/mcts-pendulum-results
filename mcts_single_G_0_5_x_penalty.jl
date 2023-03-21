## Now
include("mcts_single.jl")

file_name = "sp_G_20221219"

opts = PendulumOpts(cart_displacement_penalty = 0.5)
envfun = () -> InvertedPendulumEnv(opts)

b = single_pendulum_batch(seed_shift = 1:10, planner_file_name = nothing)
execute_batch(b, file_name, envfun = envfun, show_progress = true, start_new_file = true)
