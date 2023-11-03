## Import files
include("plot_helper.jl")

## Get file data
plot_list = CSV.read("plot_list_single_pendulum.csv", DataFrame)

## plot last one
csv_prefix = "sp_" * plot_list.id[end]
max_mean = plot_list.steps[end]

df = read_csv_from_prefix(csv_prefix)
export_heatmap_plots(df, save_svg=false, data_prefix=csv_prefix, max_mean=max_mean)

## Redo all markdown files
for pl in plot_list
    csv_prefix = "sp_" * pl.id
    max_mean = pl.steps

    df = read_csv_from_prefix(csv_prefix)
    export_heatmap_plots(df, save_svg=false, data_prefix=csv_prefix, max_mean=max_mean,
        generate_md_only=true)
end
