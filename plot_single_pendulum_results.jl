## Import files
include("plot_helper.jl")

## Single pendulun basic reward
file_name = "csv/sp_AR_20230404.csv"
fig_dir = "fig/sp_AR"
max_mean = 200

## Single pendulun basic reward 500 steps
file_name = "csv/sp_AQ_20230402.csv"
fig_dir = "fig/sp_AQ"
max_mean = 500

## Read all files
df = CSV.read(file_name, DataFrame)
export_heatmap_plots(df, save_svg = false, fig_dir = fig_dir, max_mean = max_mean)
