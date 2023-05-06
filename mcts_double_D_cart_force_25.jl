include("mcts_double.jl")

file_name = "dp_D_20230206"

dp_batch = DpBatch(exploration_param = [64, 128, 256])

execute_batch_double_args(ARGS; file_name = file_name, dp_batch = dp_batch, max_force = 25)
