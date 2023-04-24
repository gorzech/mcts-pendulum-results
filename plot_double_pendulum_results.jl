## Import files
include("plot_helper.jl")

## Double pendulun basic reward
file_name = "csv/dp_L_20230413.csv"
fig_dir = "fig/dp_L"
max_mean = 200

## Read all files
df = CSV.read(file_name, DataFrame)
# subset!(df, :gamma => ByRow(<(1.0))) # Get results for specific gamma
# subset!(df, :budget => ByRow(<(16_000)))
export_heatmap_plots(df, save_svg = false, fig_dir = fig_dir, max_mean = max_mean)
