include("mcts_double.jl")

file_name = "dp_L_20230413"
Environments.reward(env::InvertedDoublePendulumEnv) = reward_cart_angle_use_exp(
    env,
    cart_share = 0.0,
    angle_share = 1.0,
    cart_dispersion_factor = 0.25,
    angle_dispersion_factor = 0.55,
)

dp_batch = DpBatch(γ = 0.9:0.05:1.0, exploration_param = [8, 16, 32])

execute_batch_double_args(ARGS; file_name = file_name, dp_batch = dp_batch)
