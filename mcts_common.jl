Base.@kwdef struct CommandArgs
    seed_shift_start::Int = 1
    seed_shift_end::Int = 10
    planner_file_name::Union{String,Vector{String}, Nothing} = nothing
end

parse_args(args) = try
    try_parse_args(args)
catch
    print_arguments_explaination()
    rethrow()
end

function try_parse_args(args)
    if length(args) == 0
        CommandArgs()
    elseif length(args) == 1
        if tryparse(Int, args[1]) === nothing
            CommandArgs(planner_file_name = args[1])
        else
            seed_shift_start = parse(Int, args[1])
            CommandArgs(seed_shift_start = seed_shift_start, seed_shift_end = seed_shift_start)
        end
    elseif length(args) == 2
        seed_shift_start = parse(Int, args[1])
        if tryparse(Int, args[2]) === nothing
            CommandArgs(seed_shift_start = seed_shift_start, seed_shift_end = seed_shift_start, planner_file_name = args[2])
        else
            CommandArgs(seed_shift_start = seed_shift_start, seed_shift_end = parse(Int, args[2]))
        end
    else
        seed_shift_start = parse(Int, args[1])
        seed_shift_end = parse(Int, args[2])
        CommandArgs(seed_shift_start = seed_shift_start, seed_shift_end = seed_shift_end, planner_file_name = args[3:end])
    end
end

function print_arguments_explaination()
    println(
        """All arguments are optional. Multiple arguments can be provided. Those are 
[seed_shift_start, [seed_shift_end, [existing_file_names...]]]
By default seed_shift_start = 1, seed_shift_end = 10, and existing_file_name is empty.
If many file names are provided it is required to provide both seed shifts as well.""",
    )
    nothing
end

get_batch_file_name(file_name; command_args::CommandArgs) =
    "$(file_name)_$(command_args.seed_shift_start)_$(command_args.seed_shift_end)"
