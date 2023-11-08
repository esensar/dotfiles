complete -c zola -n "__fish_use_subcommand" -s r -l root -d 'Directory to use as root of project' -r -F
complete -c zola -n "__fish_use_subcommand" -s c -l config -d 'Path to a config file other than config.toml in the root of project' -r -F
complete -c zola -n "__fish_use_subcommand" -s h -l help -d 'Print help'
complete -c zola -n "__fish_use_subcommand" -s V -l version -d 'Print version'
complete -c zola -n "__fish_use_subcommand" -f -a "init" -d 'Create a new Zola project'
complete -c zola -n "__fish_use_subcommand" -f -a "build" -d 'Deletes the output directory if there is one and builds the site'
complete -c zola -n "__fish_use_subcommand" -f -a "serve" -d 'Serve the site. Rebuild and reload on change automatically'
complete -c zola -n "__fish_use_subcommand" -f -a "check" -d 'Try to build the project without rendering it. Checks links'
complete -c zola -n "__fish_use_subcommand" -f -a "completion" -d 'Generate shell completion'
complete -c zola -n "__fish_use_subcommand" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c zola -n "__fish_seen_subcommand_from init" -s f -l force -d 'Force creation of project even if directory is non-empty'
complete -c zola -n "__fish_seen_subcommand_from init" -s h -l help -d 'Print help'
complete -c zola -n "__fish_seen_subcommand_from build" -s u -l base-url -d 'Force the base URL to be that value (defaults to the one in config.toml)' -r
complete -c zola -n "__fish_seen_subcommand_from build" -s o -l output-dir -d 'Outputs the generated site in the given path (by default \'public\' dir in project root)' -r -F
complete -c zola -n "__fish_seen_subcommand_from build" -s f -l force -d 'Force building the site even if output directory is non-empty'
complete -c zola -n "__fish_seen_subcommand_from build" -l drafts -d 'Include drafts when loading the site'
complete -c zola -n "__fish_seen_subcommand_from build" -s h -l help -d 'Print help'
complete -c zola -n "__fish_seen_subcommand_from serve" -s i -l interface -d 'Interface to bind on' -r
complete -c zola -n "__fish_seen_subcommand_from serve" -s p -l port -d 'Which port to use' -r
complete -c zola -n "__fish_seen_subcommand_from serve" -s o -l output-dir -d 'Outputs assets of the generated site in the given path (by default \'public\' dir in project root). HTML/XML will be stored in memory' -r -F
complete -c zola -n "__fish_seen_subcommand_from serve" -s u -l base-url -d 'Changes the base_url' -r
complete -c zola -n "__fish_seen_subcommand_from serve" -l drafts -d 'Include drafts when loading the site'
complete -c zola -n "__fish_seen_subcommand_from serve" -s O -l open -d 'Open site in the default browser'
complete -c zola -n "__fish_seen_subcommand_from serve" -s f -l fast -d 'Only rebuild the minimum on change - useful when working on a specific page/section'
complete -c zola -n "__fish_seen_subcommand_from serve" -l no-port-append -d 'Default append port to the base url'
complete -c zola -n "__fish_seen_subcommand_from serve" -s h -l help -d 'Print help'
complete -c zola -n "__fish_seen_subcommand_from check" -l drafts -d 'Include drafts when loading the site'
complete -c zola -n "__fish_seen_subcommand_from check" -s h -l help -d 'Print help'
complete -c zola -n "__fish_seen_subcommand_from completion" -s h -l help -d 'Print help'
complete -c zola -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from serve; and not __fish_seen_subcommand_from check; and not __fish_seen_subcommand_from completion; and not __fish_seen_subcommand_from help" -f -a "init" -d 'Create a new Zola project'
complete -c zola -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from serve; and not __fish_seen_subcommand_from check; and not __fish_seen_subcommand_from completion; and not __fish_seen_subcommand_from help" -f -a "build" -d 'Deletes the output directory if there is one and builds the site'
complete -c zola -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from serve; and not __fish_seen_subcommand_from check; and not __fish_seen_subcommand_from completion; and not __fish_seen_subcommand_from help" -f -a "serve" -d 'Serve the site. Rebuild and reload on change automatically'
complete -c zola -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from serve; and not __fish_seen_subcommand_from check; and not __fish_seen_subcommand_from completion; and not __fish_seen_subcommand_from help" -f -a "check" -d 'Try to build the project without rendering it. Checks links'
complete -c zola -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from serve; and not __fish_seen_subcommand_from check; and not __fish_seen_subcommand_from completion; and not __fish_seen_subcommand_from help" -f -a "completion" -d 'Generate shell completion'
complete -c zola -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from serve; and not __fish_seen_subcommand_from check; and not __fish_seen_subcommand_from completion; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
