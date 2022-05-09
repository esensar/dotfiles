function __fish-aurfetch-list-plugins
    set -l search_string (commandline -t)
    aursearch $search_string
end

complete -c aurfetch -x -a '(__fish-aurfetch-list-plugins)'
