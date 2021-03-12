fenv source ~/.profile

set -g fish_prompt_pwd_dir_length 0
set -gx PROJECT_PATHS ~/Projects/*/* ~/Projects/Personal/Mixed\ Technology/Practice
set -gx ASDF_PYTHON_DEFAULT_PACKAGES_FILE ~/.config/asdf/.python-default-packages
set -gx FZF_DEFAULT_COMMAND 'rg --files'

alias vi "nvim"
alias vim "nvim"
alias vimdiff "nvim -d"

alias cat "bat"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

abbr -a batdiff "git diff --name-only --diff-filter=d | xargs bat --diff"

source ~/.config/fish/platform_config/$MACHINE_TYPE.fish

if [ -f /opt/asdf-vm/asdf.sh ]; then
  set -gx ASDF_DIR /opt/asdf-vm
  set -gx ASDF_CONFIG_FILE $XDG_CONFIG_HOME/asdf/asdfrc
  set -gx ASDF_DATA_DIR $XDG_DATA_HOME/asdf
  source $ASDF_DIR/asdf.sh
else
  source ~/.asdf/asdf.fish
end

eval (asdf exec direnv hook fish | source)

function direnv
	asdf exec direnv "$argv"
end
