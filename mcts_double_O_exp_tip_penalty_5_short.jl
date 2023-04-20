include("mcts_double.jl")

file_name = "dp_O_20230418"
Environments.reward(env::InvertedDoublePendulumEnv) = reward_tip_penalty_use_exp(
    env,
    x_share = 0.2,
    y_share = 0.8,
    x_dispersion_factor = 0.25,
    y_dispersion_factor = 0.25,
)

execute_batch_double_args(ARGS; file_name = file_name)
