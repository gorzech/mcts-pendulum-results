## Load required packages
using Statistics
using DataFrames
include("csv_file_support.jl")

## data to Load
csv_prefix = "dp_Y"
max_mean = 500

df = read_csv_from_prefix(csv_prefix)

## Group and combine
gdf = groupby(df, [:horizon, :budget, :exploration_param, :gamma])
stat_df = combine(gdf, :steps => mean, :steps => std)

## Get unique values for gamma and cp
all_gamma = sort!(unique(df[:, :gamma]))
all_cp = sort!(unique(df[:, :exploration_param]))

# ## Test statistics for one entry
g = all_gamma[1]
t = all_cp[1]
df_stats = subset(
    stat_df,
    [:gamma, :exploration_param] => (_g, _t) -> _g .== g .&& _t .== t,
)
df_rows = nrow(df_stats)

## Some statistics
struct StepStatistics
    mean_steps::Float64
    count_max::Int
    count_90_max::Int
    count_75_max::Int
end
function StepStatistics(df)
    field = df.steps_mean
    mean_steps = mean(field)
    cm = count(>=(max_mean), field)
    cm_90 = count(>=(max_mean * 0.9), field)
    cm_75 = count(>=(max_mean * 0.75), field)
    return StepStatistics(mean_steps, cm, cm_90, cm_75)
end

## 
st = StepStatistics(df_stats)

## Print statistics for all
println("Results for prefix $csv_prefix with max_mean $max_mean\n")
println("| \$\\gamma\$ | \$C_p\$ | mean | count max | Success rate [%] |")
println("| -- | -- | -- | -- | -- |")
for g in all_gamma
    for t in all_cp
        df_stats = subset(
            stat_df,
            [:gamma, :exploration_param] => (_g, _t) -> _g .== g .&& _t .== t,
        )
        st = StepStatistics(df_stats)
        # println("g = $g, t = $t, mean $(st.mean_steps), count $(st.count_max), c90 $(st.count_90_max), c75 $(st.count_75_max).")
        println("| $g | $t | $(st.mean_steps) | $(st.count_max) | $(round(st.count_max / df_rows * 100, digits=1)) |")
    end
end

