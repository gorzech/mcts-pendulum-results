include("mcts_double.jl")

file_name = "dp_AA_20230505"
Environments.reward(env::InvertedDoublePendulumEnv) = reward_tip_penalty_use_exp(
    env,
    x_share = 0.05,
    y_share = 0.95,
    x_dispersion_factor = 0.25,
    y_dispersion_factor = 0.25,
)

dp_batch = DpBatch(γ = 0.7:0.05:0.85, exploration_param = [0, 2, 4, 8, 16, 32, 64, 128, 256])

execute_batch_double_args(ARGS; file_name=file_name, dp_batch=dp_batch, max_steps=500)
