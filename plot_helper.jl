## Import files
using Plots
using Plots: heatmap
using Statistics
using Dates
using DataFrames
using CSV
# CSV.write("dp_r1B_ALL_20221028.csv", df)
# subset!(df, :gamma => ByRow(<(1.0))) # Get results for specific gamma
# subset!(df, :budget => ByRow(<(16_000)))

const Root_publish_directory = "docs/"
const Csv_files_directory = "csv/"

function export_heatmap_plots(df; save_svg = true, max_mean = 200, use_gr = true, data_prefix = nothing)
    gdf = groupby(df, [:horizon, :budget, :exploration_param, :gamma])
    # Compute statistics
    stat_df = combine(gdf, :steps => mean, :steps => std)

    # Now try to plot the stuff
    if use_gr
        gr()
    else
        plotlyjs()
    end
    fig_dir = get_fig_dir(data_prefix, save_svg)
    mkpath(Root_publish_directory * fig_dir)
    setup_plots(upscale_resolution = 0.8)
    
    all_gamma = sort!(unique(stat_df[:, :gamma]))
    all_cp = sort!(unique(stat_df[:, :exploration_param]))
    png_file(g, cp, stat) = "$fig_dir/$(stat)_g_$(g)_cp_$cp.png"
    svg_file(g, cp, stat) = "$fig_dir/$(data_prefix)_$(stat)_g_$(g)_cp_$cp.svg"
    file_mean(g, cp) =
        if save_svg
            svg_file(g, cp, "mean")
        else
            png_file(g, cp, "mean")
        end
    file_std(g, cp) =
        if save_svg
            svg_file(g, cp, "std")
        else
            png_file(g, cp, "std")
        end
    for g in all_gamma
        for t in all_cp
            df_plot = subset(
                stat_df,
                [:gamma, :exploration_param] => (_g, _t) -> _g .== g .&& _t .== t,
            )
            sort!(df_plot, [:budget, :horizon])
            b = if use_gr
                unique(df_plot[:, :budget])
            else
                df_plot[:, :budget]
            end
            h = if use_gr
                unique(df_plot[:, :horizon])
            else
                df_plot[:, :horizon]
            end
            
            if use_gr && length(df_plot[:, :steps_mean]) != length(h) * length(b)
                missing_points = -length(df_plot[:, :steps_mean]) + length(h) * length(b)
                println("Still $missing_points are missing for γ = $g and cp = $t")
                continue
            end

            v = if use_gr
                reshape(df_plot[:, :steps_mean], (length(h), length(b)))
            else
                df_plot[:, :steps_mean]
            end
            # println(v[findfirst(h .== 10), findfirst(b .== 100)])
            plt1 = heatmap(
                b,
                h,
                v,
                clims = (0, max_mean),
                xaxis = :log,
                c = cgrad(:tokyo, rev = false),
                xlabel = "Budget [-]",
                ylabel = "Horizon [-]",
                # linewidth=0,
                # levels = 8
            )
            Plots.savefig(plt1, Root_publish_directory * file_mean(g, t))
            v = if use_gr
                reshape(df_plot[:, :steps_std], (length(h), length(b)))
            else
                df_plot[:, :steps_std]
            end
            # println(v[findfirst(h .== 10), findfirst(b .== 100)])
            plt2 = heatmap(
                b,
                h,
                v,
                clims = (0, 80),
                xaxis = :log,
                c = cgrad(:tokyo, rev = true),
                xlabel = "Budget [-]",
                ylabel = "Horizon [-]",
            )
            Plots.savefig(plt2, Root_publish_directory * file_std(g, t))
        end
    end

    # Save md if png are generated
    date_format = "yyyy-mm-dd HH:MM:SS"
    function write_table(f, cp, all_gamma)
        # Write header
        write(f, "| \$C_p=$(cp)\$")
        for g in all_gamma
            write(f, "| \$\\gamma = $(g)\$")
        end
        write(f, "| \n")
        # Complete table header
        for _ in 1:length(all_gamma) + 1
            write(f, "| --- ")
        end
        write(f, "| \n")
        # Mean Plots
        write(f, "| Mean ")
        for g in all_gamma
            write(f, "| ![](", file_mean(g, cp), ") ")
        end
        write(f, "| \n")
        # Std Plots
        write(f, "| Std ")
        for g in all_gamma
            write(f, "| ![](", file_std(g, cp), ") ")
        end
        write(f, "| \n\n")
    end
    function get_ranges(n_total, n_split)
        [n_start:min(n_total, n_start + n_split - 1) for n_start in 1:n_split:n_total]
    end
    if !save_svg
        open(Root_publish_directory * "Plots_fig_$data_prefix.md", "w") do f
            write(f, "# Results for the file $file_name \n\n")
            write(f, "Generated on ", Dates.format(now(), date_format), "\n\n")
            for cp in all_cp
                write(f, "---\n\n**Exploration parameter = $cp**\n\n")
                ng = length(all_gamma)
                for r in get_ranges(ng, 3)
                    write_table(f, cp, all_gamma[r])
                end
            end
        end
    end
    println("Making plots complete.")
end

function get_fig_dir(data_prefix, save_svg)
    if save_svg
        "svg_fig/" * data_prefix
    else
        "fig/" * data_prefix
    end
end

function setup_plots(; upscale_resolution)
    # fntsm = Plots.font("sans-serif", pointsize = round(14 * upscale))
    fntsm = Plots.font("Times", pointsize = round(14 * upscale_resolution))
    fntlg = Plots.font("Times", pointsize = round(14 * upscale_resolution))
    default(titlefont = fntlg, guidefont = fntlg, tickfont = fntsm, legendfont = fntsm)
    default(size = (600 * upscale_resolution, 400 * upscale_resolution)) #Plot canvas size
end

function read_csv_from_prefix(prefix)
    rd = readdir(Csv_files_directory)
    csv_files = filter(x -> contains(x, prefix * "_"), rd)
    @assert length(csv_files) == 1 "After filtering only one file with prefix should be present!"

    file_name = Csv_files_directory * csv_files[1]
    df = CSV.read(file_name, DataFrame)
end