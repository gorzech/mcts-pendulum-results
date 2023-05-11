include("mcts_double.jl")

file_name = "dp_AB_20230508"
Environments.reward(env::InvertedDoublePendulumEnv) = reward_tip_penalty_use_exp(
    env,
    x_share = 0.0,
    y_share = 1.0,
    x_dispersion_factor = 0.25,
    y_dispersion_factor = 0.1,
)

dp_batch = DpBatch(γ = 0.9:0.05:1.0, exploration_param = [16, 32, 64, 128, 256])

execute_batch_double_args(ARGS; file_name=file_name, dp_batch=dp_batch, max_steps=500)
