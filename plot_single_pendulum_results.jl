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

web_page_plot_list = CSV.read("docs/_data/single_pendulum_plots.csv", DataFrame)

for pl in eachrow(plot_list)
    csv_prefix = "sp_" * pl.id
    max_mean = pl.steps

    df = read_csv_from_prefix(csv_prefix)
    export_heatmap_plots(df, save_svg=false, data_prefix=csv_prefix, max_mean=max_mean,
        generate_md_only=true)

    web_df = web_page_plot_list[web_page_plot_list.id_old.==pl.id, :]
    yaml_header_text = if isempty(web_df)
        """
        ---
        published: false
        ---

        """
    else
        @assert nrow(web_df) == 1 "There must be one record with given ID!"
        @assert web_df.steps[1] == pl.steps "The number of steps in data files is inconsistent. Please verify data!"
        """
        ---
        title: Single pendulum with $(web_df.name[1]) reward and $(web_df.steps[1]) steps
        permalink: plots/single/$(web_df.id[1]).html
        ---

        """
    end
    # println(yaml_header_text)
    # Write header at start of the file
    my_markdown = markdown_file_name(csv_prefix)
    cdata = open(io -> read(io, String), my_markdown)
    open(my_markdown, "w") do s
        # cdata = read(s, String)
        # seekstart(s)
        write(s, yaml_header_text)
        write(s, cdata)
    end
end
