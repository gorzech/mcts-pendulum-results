include("mcts_double.jl")

file_name = "dp_C_20221118" 

dp_batch = DpBatch(γ = 0.7:0.05:1.0, exploration_param = [0, 2, 4, 8, 16, 32, 64, 128, 256])

execute_batch_double_args(ARGS; file_name=file_name, dp_batch = dp_batch)