fenv source ~/.profile

set -g fish_prompt_pwd_dir_length 0
set -g __fish_git_prompt_showdirtystate 1
set -g __fish_git_prompt_showuntrackedfiles 1
set -gx MISE_PYTHON_DEFAULT_PACKAGES_FILE ~/.config/asdf/.python-default-packages
set -gx FZF_DEFAULT_COMMAND 'rg --files'

if which termux-info &> /dev/null
	alias nvim "vim"
	alias vi "vim"
	alias vimdiff "vim -d"
else
	alias vi "nvim"
	alias vim "nvim"
	alias vimdiff "nvim -d"
end

alias cat "bat"
if which termux-info &> /dev/null
else
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"
end

abbr -a batdiff "git diff --name-only --diff-filter=d | xargs bat --diff"
abbr -a ggpush "git push origin (__git.current_branch)"
abbr -a ggpull "git pull origin (__git.current_branch)"
abbr -a gcm "git checkout (__git.default_branch)"
abbr -a gst "git status"
abbr -a gcb "git checkout -b"
abbr -a ga "git add -A"
abbr -a gapa "git add -A --patch"

source ~/.config/fish/platform_config/$MACHINE_TYPE.fish

if status is-interactive
  mise activate fish | source
else
  mise activate fish --shims | source
end
