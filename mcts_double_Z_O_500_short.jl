include("mcts_double.jl")

file_name = "dp_Z_20230503"
Environments.reward(env::InvertedDoublePendulumEnv) = reward_tip_penalty_use_exp(
    env,
    x_share = 0.2,
    y_share = 0.8,
    x_dispersion_factor = 0.25,
    y_dispersion_factor = 0.25,
)

dp_batch = DpBatch(γ = 0.9:0.05:1.0, exploration_param = [0, 2, 4, 8, 64, 128, 256])

execute_batch_double_args(ARGS; file_name = file_name, dp_batch = dp_batch, max_steps = 500)
