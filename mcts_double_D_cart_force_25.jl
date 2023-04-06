using Environments
using PureMCTS

opts = PendulumOpts()
gravity = 9.81
masscart = 1.0
masspole = 0.1
total_mass = masscart + masspole
length = 0.5 # actually half the pole's length
polemass_length = 0.05
force_mag = 25.0 # default is 20 
tau = 0.02  # seconds between state updates
kinematics_integrator = "rk4"
data = Environments.PendulumData(gravity, masscart, masspole, total_mass, length, polemass_length, force_mag, tau, kinematics_integrator)

envfun = () -> InvertedDoublePendulumEnv(data, opts)
file_name = "dp_D_20230206" 
full_budget = round.(Int, exp10.(range(3, 6, 31)))

# println(br)
b = planner_batch(
    budget=full_budget,
    horizon=10:2:40,
    γ=0.7:0.05:1.0,
    exploration_param=[0, 2, 4, 8, 16, 32],
    seed_shift=1:10,
    # file_name=file_name
)
execute_batch(b, file_name, envfun=envfun, show_progress=true, start_new_file=true)
