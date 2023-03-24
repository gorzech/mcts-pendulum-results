include("mcts_single.jl")

file_name = "sp_V_20230323"
Environments.reward(env::InvertedPendulumEnv) =
    reward_cart_angle_penalty(env, cart_penalty_share=0, angle_penalty_share=1, angle_penalty_power=0.5)

execute_batch_single_args(ARGS; file_name=file_name, max_force=10.0)
