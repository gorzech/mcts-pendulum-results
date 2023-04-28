include("mcts_double.jl")

file_name = "dp_P_20230426"
Environments.reward(env::InvertedDoublePendulumEnv) = reward_cart_angle_use_exp(
    env,
    cart_share = 0.0,
    angle_share = 1.0,
    cart_dispersion_factor = 0.25,
    angle_dispersion_factor = 0.85,
)

execute_batch_double_args(ARGS; file_name = file_name)
