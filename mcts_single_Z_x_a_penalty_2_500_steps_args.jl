include("mcts_single.jl")

file_name = "sp_Z_20230324"
Environments.reward(env::InvertedPendulumEnv) = reward_cart_angle_penalty(env, cart_penalty_share = 0.25, angle_penalty_share = 0.75)
max_steps = 500

execute_batch_single_args(ARGS; file_name=file_name, max_force=10.0, max_steps = max_steps)