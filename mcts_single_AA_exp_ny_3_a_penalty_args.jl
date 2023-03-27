include("mcts_single.jl")

const theta_denom = deg2rad(3.0)

file_name = "sp_AA_20230324"
Environments.reward(env::InvertedPendulumEnv) = exp(-(env.state.y[3] / theta_denom) ^ 2)

execute_batch_single_args(ARGS; file_name=file_name, max_force=10.0)