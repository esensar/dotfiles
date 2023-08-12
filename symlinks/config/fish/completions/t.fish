function __fish-timesheets-available-projects
    grep 'account Project:.*' "$TIMESHEET_LEDGER_HOME/config/02_accounts.dat" | cut -f2 -d ' '
end

function __fish-timesheets-running-projects
    cat "$TIMESHEET_LEDGER_HOME/timesheets/$(date +%Y).journal" | grep -v ';' | awk '{ last[$4] = $1 } END { for (i in last) { if (last[i] == "i") { print i } } }'
end

function __fish-timesheets-existing-comments
    ledger -f "$TIMESHEET_LEDGER_HOME/main.journal" payees ^Project
end

function __fish_timesheets_arg_number -a number
    set -l cmd (commandline -opc)
    test (count $cmd) -eq $number
end

complete -c t -x -l help -s h -d "print usage help"
complete -c t -x -l verbose -s v -d "verbose output"
complete -c t -x -n "__fish_use_subcommand" -a in -d "start tracking time for a project"
complete -c t -x -n "__fish_use_subcommand" -a out -d "stop tracking time for a project"
complete -c t -x -n "__fish_use_subcommand" -a bal -d "print current balance"

# In
complete -c t -x -n "__fish_seen_subcommand_from in" -n "__fish_timesheets_arg_number 2" -a '(__fish-timesheets-available-projects)'
complete -c t -x -n "__fish_seen_subcommand_from in" -n "__fish_timesheets_arg_number 3" -a '(__fish-timesheets-existing-comments)'

# Out
complete -c t -x -n "__fish_seen_subcommand_from out" -a '(__fish-timesheets-running-projects)'

# Bal
complete -c t -x -n "__fish_seen_subcommand_from bal" -a '(__fish-timesheets-available-projects)'
