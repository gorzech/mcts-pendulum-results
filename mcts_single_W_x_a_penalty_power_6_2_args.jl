include("mcts_single.jl")

file_name = "sp_W_20230323"
Environments.reward(env::InvertedPendulumEnv) = reward_cart_angle_penalty(
    env,
    cart_penalty_share = 0.25,
    angle_penalty_share = 0.75,
    cart_penalty_power = 6.0,
    angle_penalty_power = 2.0,
)

execute_batch_single_args(ARGS; file_name=file_name, max_force=10.0)