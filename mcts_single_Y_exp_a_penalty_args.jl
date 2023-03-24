include("mcts_single.jl")

const rad5 = deg2rad(5.0)

file_name = "sp_Y_20230323"
Environments.reward(env::InvertedPendulumEnv) = exp(-(env.state.y[3] / rad5) ^ 2)

execute_batch_single_args(ARGS; file_name=file_name, max_force=10.0)