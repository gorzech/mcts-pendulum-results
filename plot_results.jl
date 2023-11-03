## Import files
include("plot_helper.jl")

## Single pendulun basic reward
csv_prefix = "sp3_B"
max_mean = 200

## Single pendulun basic reward 500 steps
csv_prefix = "sp_AN"
max_mean = 500

## Read all files
df = read_csv_from_prefix(csv_prefix)
export_heatmap_plots(df, save_svg = false, data_prefix = csv_prefix, max_mean = max_mean)
