include("mcts_single.jl")

file_name = "sp_L_20230315"
max_force = 10.0 # default is 10.0
Environments.reward(env::InvertedPendulumEnv) =
    reward_angle_penalty(env::InvertedPendulumEnv)

seed_shift = seed_shoft_from_args(ARGS)

batch_file_name = get_batch_file_name(file_name, seed_shift = seed_shift)
println("Save results to $batch_file_name")

opts = PendulumOpts()
data = Environments.PendulumData(9.81, 1.0, 0.1, 1.1, 0.5, 0.05, max_force, 0.02, "euler")
envfun = () -> InvertedPendulumEnv(data, opts)

b = single_pendulum_batch(seed_shift = seed_shift, planner_file_name = nothing)

execute_batch(
    b,
    batch_file_name,
    envfun = envfun,
    show_progress = true,
    start_new_file = true,
    file_dump_interval = 20,
)
