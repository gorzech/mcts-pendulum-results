using CSV, DataFrames
function combine_to_single_csv_from_prefix(prefix, target_file_name)
    file_names = files_starts_with(prefix)
    df = CSV.read(file_names, DataFrame)
    CSV.write(target_file_name, df)
    return df
end

function files_starts_with(prefix)
    rd = readdir()
    filter(x -> contains(x, prefix), rd)
end

# prefix = "sp_AR_"
# file_name = "sp_AR_20230404"

prefix = "dp_R_"
file_name = "dp_R_20230428"

combine_to_single_csv_from_prefix(prefix, "csv/$file_name.csv")

