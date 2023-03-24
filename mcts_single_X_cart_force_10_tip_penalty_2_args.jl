include("mcts_single.jl")

file_name = "sp_X_20230323"
Environments.reward(env::InvertedPendulumEnv) = reward_tip_penalty(env::InvertedPendulumEnv, x_tip_threshold=0.25,
    y_tip_threshold=0.75)

execute_batch_single_args(ARGS; file_name=file_name, max_force=10.0)