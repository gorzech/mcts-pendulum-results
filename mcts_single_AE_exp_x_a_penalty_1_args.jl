include("mcts_single.jl")

file_name = "sp_AE_20230327"
Environments.reward(env::InvertedPendulumEnv) = reward_cart_angle_use_exp(
    env,
    cart_share = 0.25,
    angle_share = 0.75,
    cart_dispersion_factor = 0.25,
    angle_dispersion_factor = 0.25, # same as AA
)

execute_batch_single_args(ARGS; file_name = file_name, max_force = 10.0)
