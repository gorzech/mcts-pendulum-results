include("mcts_double.jl")

file_name = "dp_Q_20230426"
Environments.reward(env::InvertedDoublePendulumEnv) = reward_cart_angle_use_exp(
    env,
    cart_share = 0.15,
    angle_share = 0.85,
    cart_dispersion_factor = 0.7,
    angle_dispersion_factor = 0.7,
)

execute_batch_double_args(ARGS; file_name = file_name)
