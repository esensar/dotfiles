function __fish-timesheets-available-projects
    timelog -q accounts
end

function __fish-timesheets-running-projects
    timelog -q accounts -r
end

function __fish-timesheets-available-tasks -a account
    timelog -q tasks $account
end

function __fish-timesheets-running-tasks -a account
    timelog -q tasks -r $account
end

function __fish_timesheets_arg_number -a number
    set -l cmd (commandline -opc)
    test (count $cmd) -eq $number
end

function __fish_timesheets_get_arg -a number
    set -l cmd (commandline -opc)
    echo $cmd[$number]
end

complete -c timelog -x -l help -s h -d "print usage help"
complete -c timelog -x -l verbose -s v -d "verbose output"
complete -c timelog -x -n "__fish_use_subcommand" -a in -d "start tracking time for a project"
complete -c timelog -x -n "__fish_use_subcommand" -a out -d "stop tracking time for a project"
complete -c timelog -x -n "__fish_use_subcommand" -a toggle -d "toggle tracking time"
complete -c timelog -x -n "__fish_use_subcommand" -a undo -d "undo last command"
complete -c timelog -x -n "__fish_use_subcommand" -a invoice -d "generate an invoice"
complete -c timelog -x -n "__fish_use_subcommand" -a balance -d "show current balance"
complete -c timelog -x -n "__fish_use_subcommand" -a today -d "generate data for today"
complete -c timelog -x -n "__fish_use_subcommand" -a status -d "show status"
complete -c timelog -x -n "__fish_use_subcommand" -a waybar -d "generate data for waybar"

# In
complete -c timelog -x -n "__fish_seen_subcommand_from in" -n "__fish_timesheets_arg_number 2" -a '(__fish-timesheets-available-projects)'
complete -c timelog -x -n "__fish_seen_subcommand_from in" -n "__fish_timesheets_arg_number 3" -a '(__fish-timesheets-available-tasks (__fish_timesheets_get_arg 3))'

# Switch
complete -c timelog -x -n "__fish_seen_subcommand_from switch" -n "__fish_timesheets_arg_number 2" -a '(__fish-timesheets-available-projects)'
complete -c timelog -x -n "__fish_seen_subcommand_from switch" -n "__fish_timesheets_arg_number 3" -a '(__fish-timesheets-available-tasks (__fish_timesheets_get_arg 3))'

# Out
complete -c timelog -x -n "__fish_seen_subcommand_from out" -n "__fish_timesheets_arg_number 2" -a '(__fish-timesheets-running-projects)'
complete -c timelog -x -n "__fish_seen_subcommand_from out" -n "__fish_timesheets_arg_number 3" -a '(__fish-timesheets-running-tasks (__fish_timesheets_get_arg 3))'

# Bal
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -a '(__fish-timesheets-available-projects)'

# Invoice
complete -c timelog -x -n "__fish_seen_subcommand_from report" -n "__fish_timesheets_arg_number 2" -a '(__fish-timesheets-available-projects)'
complete -c timelog -x -n "__fish_seen_subcommand_from report" -n "__fish_timesheets_arg_number 3" -a '(__fish-timesheets-available-tasks (__fish_timesheets_get_arg 3))'
