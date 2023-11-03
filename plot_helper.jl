## Import files
using Plots
using Plots: heatmap
using Statistics
using Dates
using DataFrames

include("csv_file_support.jl")
# CSV.write("dp_r1B_ALL_20221028.csv", df)
# subset!(df, :gamma => ByRow(<(1.0))) # Get results for specific gamma
# subset!(df, :budget => ByRow(<(16_000)))

const Root_publish_directory = "docs/"
const Date_format = "yyyy-mm-dd HH:MM:SS"

function export_heatmap_plots(df; save_svg=true, max_mean=200, use_gr=true, 
    data_prefix=nothing, generate_md_only=false)
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
    setup_plots(upscale_resolution=0.8)

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
    
    all_gamma = sort!(unique(stat_df[:, :gamma]))
    all_cp = sort!(unique(stat_df[:, :exploration_param]))

    success_rates = Dict{Tuple{Float64, Int64}, Float64}()
    for g in all_gamma
        for cp in all_cp
            df_plot = subset(
                stat_df,
                [:gamma, :exploration_param] => (_g, _cp) -> _g .== g .&& _cp .== cp,
            )
            success_rates[(g,cp)] = success_rate(df_plot, max_mean)
            sort!(df_plot, [:budget, :horizon])
            if generate_md_only
                continue
            end
            plot_data = HeatmapPlotData(df_plot, use_gr=use_gr)
            plt_mean = plot_heatmap_mean(plot_data, max_mean)
            Plots.savefig(plt_mean, Root_publish_directory * file_mean(g, cp))
            plt_std = plot_heatmap_std(plot_data)
            Plots.savefig(plt_std, Root_publish_directory * file_std(g, cp))
        end
    end

    # Save md if png are generated
    function write_table(f, cp, all_gamma)
        # Write header
        write(f, "| Cₚ = $(cp) ")
        for g in all_gamma
            S = success_rates[(g,cp)]
            write(f, "| γ = $g, S = $(round(S * 100, digits=2))% ")
        end
        write(f, "| \n")
        # Complete table header
        for _ in 1:length(all_gamma)+1
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
        csv_file = get_csv_filename_from_prefix(data_prefix)
        open(markdown_file_name(data_prefix), "w") do f
            write(f, "# Results for the file $csv_file \n\n")
            write(f, "Generated on ", Dates.format(now(), Date_format), "\n\n")
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

markdown_file_name(data_prefix) = Root_publish_directory * "Plots_fig_$data_prefix.md"


function success_rate(df, max_mean)
    field = df.steps_mean
    max_mean_count = count(>=(max_mean), field)
    all_count = length(field)
    return max_mean_count / all_count
end

function plot_heatmap_mean(plot_data::HeatmapPlotData, max_mean)
    heatmap(
        plot_data.budget,
        plot_data.horizon,
        plot_data.steps_mean,
        clims=(0, max_mean),
        xaxis=:log,
        c=cgrad(:tokyo, rev=false),
        xlabel="Budget [-]",
        ylabel="Horizon [-]",
    )
end

function plot_heatmap_std(plot_data::HeatmapPlotData, max_std=80)
    heatmap(
        plot_data.budget,
        plot_data.horizon,
        plot_data.steps_std,
        clims=(0, 80),
        xaxis=:log,
        c=cgrad(:tokyo, rev=true),
        xlabel="Budget [-]",
        ylabel="Horizon [-]",
    )
end


struct HeatmapPlotData
    budget::Vector{Float64}
    horizon::Vector{Float64}
    steps_mean::Matrix{Float64}
    steps_std::Matrix{Float64}
end

function HeatmapPlotData(df_plot; use_gr=true)
    if use_gr
        try
            return _heatmap_plot_data_for_gr(df_plot)
        catch e
            println("Cannot generate plots with GR!")
            println(e.message)
        end
    end
    return _heatmap_plot_data_for_plotly(df_plot)
end

function _heatmap_plot_data_for_plotly(df_plot)
    return HeatmapPlotData(
        df_plot[:, :budget],
        df_plot[:, :horizon],
        df_plot[:, :steps_mean],
        df_plot[:, :steps_std]
    )
end

function _heatmap_plot_data_for_gr(df_plot)
    b = unique(df_plot[:, :budget])
    h = unique(df_plot[:, :horizon])

    if length(df_plot[:, :steps_mean]) != length(h) * length(b)
        missing_points = -length(df_plot[:, :steps_mean]) + length(h) * length(b)
        # println("Still $missing_points are missing for γ = $(df_plot[1, :gamma]) and cp = $(df_plot[1, :exploration_param])")
        message = "Still $missing_points are missing for γ = $(df_plot[1, :gamma]) and cp = $(df_plot[1, :exploration_param])"
        throw(BoundsError(message))
    end

    steps_mean = reshape(df_plot[:, :steps_mean], (length(h), length(b)))
    steps_std = reshape(df_plot[:, :steps_std], (length(h), length(b)))
    return HeatmapPlotData(b, h, steps_mean, steps_std)
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
    fntsm = Plots.font("Times", pointsize=round(14 * upscale_resolution))
    fntlg = Plots.font("Times", pointsize=round(14 * upscale_resolution))
    default(titlefont=fntlg, guidefont=fntlg, tickfont=fntsm, legendfont=fntsm)
    default(size=(600 * upscale_resolution, 400 * upscale_resolution)) #Plot canvas size
end
