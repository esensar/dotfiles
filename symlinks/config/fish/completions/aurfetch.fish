function __fish-aurfetch-list-installable
    set -l search_string (commandline -t)
    aursearch $search_string
end

function __fish-aurfetch-list-installed
    pacman -Qm
end

complete -c aurfetch -x -l help -s h -d "print usage help"
complete -c aurfetch -x -l verbose -s v -d "verbose output"
complete -c aurfetch -x -n "__fish_use_subcommand" -a update -d "update an installed package"
complete -c aurfetch -x -n "__fish_use_subcommand" -a install -d "install a new package"
complete -c aurfetch -x -n "__fish_use_subcommand" -a uninstall -d "uninstall an installed package"

# Install
complete -c aurfetch -x -n "__fish_seen_subcommand_from install" -l quick -s q -d "install without checking PKGBUILD"
complete -c aurfetch -x -n "__fish_seen_subcommand_from install" -a '(__fish-aurfetch-list-installable)'

# Update
complete -c aurfetch -x -n "__fish_seen_subcommand_from update" -l quick -s q -d "update without checking diff"
complete -c aurfetch -x -n "__fish_seen_subcommand_from update" -a '(__fish-lsp-installed-servers)'

# Uninstall
complete -c aurfetch -x -n "__fish_seen_subcommand_from uninstall" -l keep-cache -s k -d "keep AUR cache for quicker reinstall"
complete -c aurfetch -x -n "__fish_seen_subcommand_from uninstall" -a '(__fish-lsp-installed-servers)'
