using Environments
import Environments: reward
using PureMCTS
# using Plots


function reward_cart_angle_use_exp(
    env::InvertedPendulumEnv;
    cart_share = 0.0,
    angle_share = 1.0,
    cart_dispersion_factor = 0.25,
    angle_dispersion_factor = 0.25,
)
    x = env.state.y[1]
    θ = env.state.y[3]
    cart_reward = exp(-(x / env.opts.x_threshold / cart_dispersion_factor)^2)
    angle_reward = exp(-(θ / env.opts.theta_threshold_radians / angle_dispersion_factor)^2)
    return cart_share * cart_reward + angle_share * angle_reward
end

function reward_cart_angle_penalty(
    env::InvertedPendulumEnv;
    cart_penalty_share = 0.5,
    angle_penalty_share = 0.5,
    cart_penalty_power = 1.0,
    angle_penalty_power = 1.0,
)
    x = env.state.y[1]
    θ = env.state.y[3]
    cart_penalty = abs(x / env.opts.x_threshold)^cart_penalty_power
    angle_penalty = abs(θ / env.opts.theta_threshold_radians)^angle_penalty_power
    return 1.0 - cart_penalty_share * cart_penalty - angle_penalty_share * angle_penalty
end

reward_angle_penalty(env::InvertedPendulumEnv) =
    1.0 - abs(env.state.y[3]) / env.opts.theta_threshold_radians

function reward_tip_penalty(
    env::InvertedPendulumEnv;
    x_tip_threshold = 0.5,
    y_tip_threshold = 0.5,
)
    x = env.state.y[1]
    θ = env.state.y[3]
    l = 2 * env.data.length
    x_tip = x - l * sin(θ)
    y_tip_largest_drop = l * (1 - cos(env.opts.theta_threshold_radians))
    y_tip_drop = l * (1 - cos(θ))
    return 1.0 - x_tip_threshold * abs(x_tip) / env.opts.x_threshold -
           y_tip_threshold * y_tip_drop / y_tip_largest_drop
end

function reward_tip_penalty_use_exp(
    env::InvertedPendulumEnv;
    x_share = 0.0,
    y_share = 1.0,
    x_dispersion_factor = 0.25,
    y_dispersion_factor = 0.25,
)
    x = env.state.y[1]
    θ = env.state.y[3]
    l = 2 * env.data.length
    x_tip = x - l * sin(θ)
    y_tip_largest_drop = l * (1 - cos(env.opts.theta_threshold_radians))
    y_tip_drop = l * (1 - cos(θ))
    x_reward = exp(-(abs(x_tip) / env.opts.x_threshold / x_dispersion_factor)^2)
    y_reward = exp(-(y_tip_drop / y_tip_largest_drop / y_dispersion_factor)^2)
    return x_share * x_reward + y_share * y_reward
end

function check_reward_here_and_there(reward_function)
    env = InvertedPendulumEnv()
    reset!(env)

    for x in LinRange(-env.opts.x_threshold, env.opts.x_threshold, 5)
        println("Displacement x = $x")
        for θ in
            LinRange(-env.opts.theta_threshold_radians, env.opts.theta_threshold_radians, 5)
            env.state.y = [x, 0.0, θ, 0.0]
            print("$θ: $(reward_function(env)), ")
        end
        println("")
    end
end

function plot_reward_along_angle(reward_function)
    env = InvertedPendulumEnv()
    reset!(env)

    x = 0.0
    angles = LinRange(-env.opts.theta_threshold_radians, env.opts.theta_threshold_radians, 101)
    rewards = map((θ) -> begin
        env.state.y = [x, 0.0, θ, 0.0]
        reward_function(env)
    end, angles)

    plot(angles, rewards)
end