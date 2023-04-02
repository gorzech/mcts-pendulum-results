include("mcts_single.jl")

file_name = "sp_AO_20230401"
Environments.reward(env::InvertedPendulumEnv) = reward_cart_angle_use_exp(
    env,
    cart_share = 0.15,
    angle_share = 0.85,
    cart_dispersion_factor = 0.25,
    angle_dispersion_factor = 0.25,
)

execute_batch_single_args(ARGS; file_name = file_name, max_force = 10.0, max_steps=500)
