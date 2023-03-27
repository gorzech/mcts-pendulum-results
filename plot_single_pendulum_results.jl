## Import files
include("plot_helper.jl")


## Single pendulun basic reward
file_name = "csv/sp_AD_20230326.csv"
fig_dir = "fig/sp_AD"
max_mean = 200

## Single pendulun basic reward 500 steps
file_name = "csv/sp_Z_20230324.csv"
fig_dir = "fig/sp_Z"
max_mean = 500

## Read all files
df = CSV.read(file_name, DataFrame)

# CSV.write("dp_r1B_ALL_20221028.csv", df)
# subset!(df, :gamma => ByRow(<(1.0))) # Get results for specific gamma
# subset!(df, :budget => ByRow(<(16_000)))
export_heatmap_plots(df, save_svg = false, fig_dir = fig_dir, max_mean = max_mean)
