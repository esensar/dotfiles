alias cat "bat"
if which termux-info &> /dev/null
else
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"
end

abbr -a batdiff "git diff --name-only --diff-filter=d | xargs bat --diff"
