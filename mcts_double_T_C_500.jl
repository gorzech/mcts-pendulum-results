include("mcts_double.jl")

file_name = "dp_T_20230501" 

dp_batch = DpBatch(γ = 0.7:0.05:0.85, exploration_param = [0, 2, 4, 8, 16, 32, 64, 128, 256])

execute_batch_double_args(ARGS; file_name=file_name, dp_batch=dp_batch, max_steps=500)
