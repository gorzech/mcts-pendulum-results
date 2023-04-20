include("mcts_double.jl")

file_name = "dp_K_20230411"
Environments.reward(env::InvertedDoublePendulumEnv) = reward_tip_penalty_use_exp(
    env,
    x_share = 0.0,
    y_share = 1.0,
    x_dispersion_factor = 0.25,
    y_dispersion_factor = 0.4,
)

execute_batch_double_args(ARGS; file_name = file_name)
