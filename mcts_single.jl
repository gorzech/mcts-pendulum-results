using LinearAlgebra
using MKL
# BLAS.set_num_threads(1)
using Environments
import Environments: reward
using PureMCTS

include("mcts_common.jl")
include("mcts_single_rewards.jl")

function execute_batch_single_args(args; file_name, max_force = 10.0, max_steps = 200)
    cmd_args = parse_args(args)
    b = single_pendulum_batch(command_args = cmd_args)

    opts = PendulumOpts(max_steps = max_steps)
    data =
        Environments.PendulumData(9.81, 1.0, 0.1, 1.1, 0.5, 0.05, max_force, 0.02, "euler")
    envfun = () -> InvertedPendulumEnv(data, opts)

    batch_file_name = get_batch_file_name(file_name, command_args = cmd_args)
    println("Save results to $batch_file_name")


    execute_batch(
        b,
        batch_file_name,
        envfun = envfun,
        show_progress = true,
        start_new_file = true,
        file_dump_interval = 100,
    )
end

function single_pendulum_batch(; command_args::CommandArgs)
    full_budget = round.(Int, exp10.(range(1, 5, 81)))
    full_budget = full_budget[(full_budget.>=30)]

    return planner_batch(
        budget = full_budget,
        horizon = 4:30,
        γ = 0.5:0.05:1.0,
        exploration_param = [0, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024],
        seed_shift = command_args.seed_shift_start:command_args.seed_shift_end,
        file_name = command_args.planner_file_name,
    )
end
