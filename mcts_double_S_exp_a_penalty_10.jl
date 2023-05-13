include("mcts_double.jl")

file_name = "dp_S_20230428"
Environments.reward(env::InvertedDoublePendulumEnv) = reward_cart_angle_use_exp(
    env,
    cart_share = 0.15,
    angle_share = 0.85,
    cart_dispersion_factor = 0.4,
    angle_dispersion_factor = 0.7,
)

dp_batch = DpBatch(exploration_param = [64, 128, 256])

execute_batch_double_args(ARGS; file_name=file_name, dp_batch = dp_batch)
