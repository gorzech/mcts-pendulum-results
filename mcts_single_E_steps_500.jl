include("mcts_single.jl")

file_name = "sp_E_20221215"
max_steps = 500

opts = PendulumOpts(max_steps = max_steps)
envfun = () -> InvertedPendulumEnv(opts)
full_budget = round.(Int, exp10.(range(1, 5, 81)))
full_budget = full_budget[(full_budget.>=30)]

b = single_pendulum_batch(seed_shift = 1:10, planner_file_name = nothing)

execute_batch(b, file_name, envfun = envfun, show_progress = true, start_new_file = true)
