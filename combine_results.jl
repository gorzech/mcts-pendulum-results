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

prefix = "sp_E_"
file_name = "sp_E_20221215"

combine_to_single_csv_from_prefix(prefix, "csv/$file_name.csv")

