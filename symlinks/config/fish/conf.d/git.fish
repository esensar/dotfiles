set -g __fish_git_prompt_showdirtystate 1
set -g __fish_git_prompt_showuntrackedfiles 1
set -g __fish_git_prompt_showcolorhints 1
set -g ___fish_git_prompt_color_branch (set_color --bold "98971A")

abbr -a gst "git status"
abbr -a gsw "git switch"
abbr -a gswm "git switch (__git.default_branch)"
abbr -a gr "git restore"
abbr -a grp "git restore --patch"
abbr -a grs "git restore --staged"
abbr -a grsp "git restore --staged --patch"
abbr -a ga "git add"
abbr -a gaa "git add -A"
abbr -a gapa "git add --patch"
abbr -a gcv "git commit -v"
