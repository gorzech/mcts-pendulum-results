using LinearAlgebra
using MKL
# BLAS.set_num_threads(1)
using Environments
import Environments: reward
using PureMCTS

include("mcts_common.jl")
include("mcts_double_rewards.jl")

Base.@kwdef struct DpBatch
    γ = 0.7:0.05:1.0
    exploration_param::Vector{Int} = [0, 2, 4, 8, 16, 32]
end

function execute_batch_double_args(
    args;
    file_name,
    max_force=20.0,
    max_steps=200,
    dp_batch::DpBatch=DpBatch()
)
    cmd_args = parse_args(args)
    b = double_pendulum_batch(command_args=cmd_args, dp_batch=dp_batch)

    opts = PendulumOpts(max_steps=max_steps)

    gravity = 9.81
    masscart = 1.0
    masspole = 0.1
    total_mass = masscart + masspole
    length = 0.5 # actually half the pole's length
    polemass_length = 0.05
    tau = 0.02  # seconds between state updates
    kinematics_integrator = "rk4"
    data = Environments.PendulumData(
        gravity,
        masscart,
        masspole,
        total_mass,
        length,
        polemass_length,
        max_force,
        tau,
        kinematics_integrator,
    )

    envfun = () -> InvertedDoublePendulumEnv(data, opts)

    batch_file_name = get_batch_file_name(file_name, command_args=cmd_args)
    println("Save results to $batch_file_name")

    execute_batch(
        b,
        batch_file_name,
        envfun=envfun,
        show_progress=true,
        start_new_file=true,
        file_dump_interval=100,
    )
end

function double_pendulum_batch(; command_args::CommandArgs, dp_batch::DpBatch=DpBatch())
    full_budget = round.(Int, exp10.(range(3, 6, 31)))

    planner_batch(
        budget=full_budget,
        horizon=10:2:40,
        γ=dp_batch.γ,
        exploration_param=dp_batch.exploration_param,
        seed_shift=command_args.seed_shift_start:command_args.seed_shift_end,
        file_name=command_args.planner_file_name,
    )
end
