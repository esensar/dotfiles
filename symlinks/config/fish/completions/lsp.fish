function __fish-lsp-available-servers
    lsp status --all | grep 'Server.*:' | awk '{print $2}' | sed 's/[:,]//g' | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"
end

function __fish-lsp-installed-servers
    lsp status | grep 'Server.*:' | awk '{print $2}' | sed 's/[:,]//g' | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"
end

complete -c lsp -x -l help -s h -d "print usage help"
complete -c lsp -x -l verbose -s v -d "verbose output"
complete -c lsp -x -n "__fish_use_subcommand" -a status -d "status of installed servers"
complete -c lsp -x -n "__fish_use_subcommand" -a link -d "link installed server to location in PATH (~/.local/bin)"
complete -c lsp -x -n "__fish_use_subcommand" -a install -d "install a new server"
complete -c lsp -x -n "__fish_use_subcommand" -a uninstall -d "uninstall an installed server"

# Install
complete -c lsp -x -n "__fish_seen_subcommand_from install" -l link -s l -d "link server after installation"
complete -c lsp -x -n "__fish_seen_subcommand_from install" -a '(__fish-lsp-available-servers)'

# Link
complete -c lsp -x -n "__fish_seen_subcommand_from link" -a '(__fish-lsp-installed-servers)'

# Uninstall
complete -c lsp -x -n "__fish_seen_subcommand_from uninstall" -a '(__fish-lsp-installed-servers)'

# Status
complete -c lsp -x -n "__fish_seen_subcommand_from status" -l known-only -s k -d "show only known servers"
complete -c lsp -x -n "__fish_seen_subcommand_from status" -l all -s a -d "show all supported servers"
complete -c lsp -x -n "__fish_seen_subcommand_from status" -a '(__fish-lsp-available-servers)'
