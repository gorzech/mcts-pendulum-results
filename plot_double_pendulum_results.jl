## Import files
include("plot_helper.jl")

## Double pendulun basic reward
csv_prefix = "dp_D"
max_mean = 200

## Double pendulun 500 steps
csv_prefix = "dp_AA"
max_mean = 500

## Read all files
df = read_csv_from_prefix(csv_prefix)
# subset!(df, :gamma => ByRow(<(1.0))) # Get results for specific gamma
# subset!(df, :budget => ByRow(<(16_000)))
export_heatmap_plots(df, save_svg = false, data_prefix = csv_prefix, max_mean = max_mean)
