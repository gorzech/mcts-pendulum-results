using CSV

const Csv_files_directory = "csv/"

function read_csv_from_prefix(prefix)
    csv_file = get_csv_filename_from_prefix(prefix)
    file_name = Csv_files_directory * csv_file
    CSV.read(file_name, DataFrame)
end

function get_csv_filename_from_prefix(prefix)
    rd = readdir(Csv_files_directory)
    csv_files = filter(x -> contains(x, prefix * "_"), rd)
    @assert length(csv_files) == 1 "After filtering only one file with prefix should be present!"
    return csv_files[1]
end
