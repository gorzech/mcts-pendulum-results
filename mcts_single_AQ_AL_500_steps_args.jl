include("mcts_single.jl")

file_name = "sp_AQ_20230401"
Environments.reward(env::InvertedPendulumEnv) = reward_tip_penalty_use_exp(
    env,
    x_share = 0.0,
    y_share = 1.0,
    x_dispersion_factor = 0.25,
    y_dispersion_factor = 0.1,
)

execute_batch_single_args(ARGS; file_name = file_name, max_force = 10.0, max_steps=500)
