function __fish-timesheets-available-accounts
    timelog -q accounts
end

function __fish-timesheets-running-accounts
    timelog -q accounts -r
end

function __fish-timesheets-available-tasks -a account
    timelog -q tasks $account
end

function __fish-timesheets-running-tasks -a account
    timelog -q tasks -r $account
end

function __fish-timesheets-available-timerefs
    for ref in "today" "this week" "this month" "this year" "yesterday" "last week" "last month" "last year" "tomorrow" "next week" "next month" "next year"
        echo $ref
    end
end

function __fish-timesheets-available-events
    timelog -q events
end

function __fish_timesheets_arg_number -a number
    set -l cmd (commandline -opc)
    test (count $cmd) -eq $number
end

function __fish_timesheets_get_arg -a number
    set -l cmd (commandline -opc)
    echo $cmd[$number]
end

complete -c timelog -s C -ra "NONE" -F -d "use default config"
complete -c timelog -s h -d "print usage help"
complete -c timelog -s v -d "verbose output"
complete -c timelog -s q -d "quiet output"
complete -c timelog -x -n "__fish_use_subcommand" -a in -d "start tracking time for a task"
complete -c timelog -x -n "__fish_use_subcommand" -a out -d "stop tracking time for a task"
complete -c timelog -x -n "__fish_use_subcommand" -a log -d "log a time block for a task"
complete -c timelog -x -n "__fish_use_subcommand" -a toggle -d "toggle tracking time"
complete -c timelog -x -n "__fish_use_subcommand" -a undo -d "undo last command"
complete -c timelog -x -n "__fish_use_subcommand" -a invoice -d "generate an invoice"
complete -c timelog -x -n "__fish_use_subcommand" -a balance -d "show current balance"
complete -c timelog -x -n "__fish_use_subcommand" -a today -d "generate data for today"
complete -c timelog -x -n "__fish_use_subcommand" -a status -d "show status"

# In
complete -c timelog -x -n "__fish_seen_subcommand_from in" -n "__fish_timesheets_arg_number 2" -a '(__fish-timesheets-available-accounts)'
complete -c timelog -x -n "__fish_seen_subcommand_from in" -n "__fish_timesheets_arg_number 3" -a '(__fish-timesheets-available-tasks (__fish_timesheets_get_arg 3))'
complete -c timelog -x -n "__fish_seen_subcommand_from in" -s h -d "print usage help"
complete -c timelog -x -n "__fish_seen_subcommand_from in" -s s -d "set strict mode for this operation"
complete -c timelog -x -n "__fish_seen_subcommand_from in" -s l -d "disable strict mode for this operation"
complete -c timelog -x -n "__fish_seen_subcommand_from in" -s x -d "set exclusive-per-account flag"
complete -c timelog -x -n "__fish_seen_subcommand_from in" -s X -d "set exclusive flag"

# Log
complete -c timelog -x -n "__fish_seen_subcommand_from log" -n "__fish_timesheets_arg_number 2" -a '(__fish-timesheets-available-accounts)'
complete -c timelog -x -n "__fish_seen_subcommand_from log" -n "__fish_timesheets_arg_number 3" -a '(__fish-timesheets-available-tasks (__fish_timesheets_get_arg 3))'
complete -c timelog -x -n "__fish_seen_subcommand_from log" -s h -d "print usage help"
complete -c timelog -x -n "__fish_seen_subcommand_from log" -s s -d "set strict mode for this operation"
complete -c timelog -x -n "__fish_seen_subcommand_from log" -s l -d "disable strict mode for this operation"
complete -c timelog -x -n "__fish_seen_subcommand_from log" -s x -d "set exclusive-per-account flag"
complete -c timelog -x -n "__fish_seen_subcommand_from log" -s X -d "set exclusive flag"
complete -c timelog -x -n "__fish_seen_subcommand_from log" -s b -a '(__fish-timesheets-available-timerefs)' -d "timeref"
complete -c timelog -x -n "__fish_seen_subcommand_from log" -s b -a '(__fish-timesheets-available-events)' -d "event"

# Switch
complete -c timelog -x -n "__fish_seen_subcommand_from switch" -n "__fish_timesheets_arg_number 2" -a '(__fish-timesheets-available-accounts)'
complete -c timelog -x -n "__fish_seen_subcommand_from switch" -n "__fish_timesheets_arg_number 3" -a '(__fish-timesheets-available-tasks (__fish_timesheets_get_arg 3))'

# Out
complete -c timelog -x -n "__fish_seen_subcommand_from out" -n "__fish_timesheets_arg_number 2" -a '(__fish-timesheets-running-accounts)'
complete -c timelog -x -n "__fish_seen_subcommand_from out" -n "__fish_timesheets_arg_number 3" -a '(__fish-timesheets-running-tasks (__fish_timesheets_get_arg 3))'
complete -c timelog -x -n "__fish_seen_subcommand_from out" -s h -d "print usage help"
complete -c timelog -x -n "__fish_seen_subcommand_from out" -s s -d "set strict mode for this operation"
complete -c timelog -x -n "__fish_seen_subcommand_from out" -s l -d "disable strict mode for this operation"
complete -c timelog -x -n "__fish_seen_subcommand_from out" -s a -d "target all accounts"

# Bal
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -a '(__fish-timesheets-available-accounts)'
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -s h -d "print usage help"
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -s d -d "duration format"
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -s t -d "date/time format"
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -s b -a '(__fish-timesheets-available-timerefs)' -d "timeref"
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -s b -a '(__fish-timesheets-available-events)' -d "event"
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -s e -a '(__fish-timesheets-available-timerefs)' -d "timeref"
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -s e -a '(__fish-timesheets-available-events)' -d "event"

# Status
complete -c timelog -x -n "__fish_seen_subcommand_from status" -a '(__fish-timesheets-available-accounts)'
complete -c timelog -x -n "__fish_seen_subcommand_from status" -s h -d "print usage help"
complete -c timelog -x -n "__fish_seen_subcommand_from status" -s d -d "duration format"
complete -c timelog -x -n "__fish_seen_subcommand_from status" -s t -d "date/time format"
complete -c timelog -x -n "__fish_seen_subcommand_from status" -s f -d "header format"
complete -c timelog -x -n "__fish_seen_subcommand_from status" -s T -d "statusline format"
complete -c timelog -x -n "__fish_seen_subcommand_from status" -s s -d "short mode"

# Invoice
complete -c timelog -x -n "__fish_use_subcommand" -a report -d "reports extension"
complete -c timelog -x -n "__fish_seen_subcommand_from report" -n "__fish_timesheets_arg_number 2" -a new -d "create a new report"
complete -c timelog -x -n "__fish_seen_subcommand_from report new" -n "__fish_seen_subcommand_from new" -n "__fish_timesheets_arg_number 3" -a '(__fish-timesheets-available-accounts)'
complete -c timelog -x -n "__fish_seen_subcommand_from report new" -n "__fish_seen_subcommand_from new" -n "__fish_timesheets_arg_number 4" -a '(__fish-timesheets-available-tasks (__fish_timesheets_get_arg 4))'
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -s h -d "print usage help"
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -s o -d "output path"
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -s t -d "template path"
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -s b -a '(__fish-timesheets-available-timerefs)' -d "timeref"
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -s b -a '(__fish-timesheets-available-events)' -d "event"
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -s e -a '(__fish-timesheets-available-timerefs)' -d "timeref"
complete -c timelog -x -n "__fish_seen_subcommand_from balance" -s e -a '(__fish-timesheets-available-events)' -d "event"
