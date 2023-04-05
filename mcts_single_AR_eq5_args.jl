include("mcts_single.jl")

file_name = "sp_AR_20230404"
Environments.reward(env::InvertedPendulumEnv) = begin
    θ = rad2deg(env.state.y[3])
    if θ > 2
        exp(-((θ - 2) / 3) ^ 2)
    else
        exp(-((θ - 2) / 5) ^ 2)
    end
end

execute_batch_single_args(ARGS; file_name = file_name, max_force = 10.0, max_steps=200)
