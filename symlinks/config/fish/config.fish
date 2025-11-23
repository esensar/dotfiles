fenv source ~/.profile

set -g fish_prompt_pwd_dir_length 0
set -g fish_color_cwd "458588"
set -gx MISE_PYTHON_DEFAULT_PACKAGES_FILE ~/.config/asdf/.python-default-packages
set -gx FZF_DEFAULT_COMMAND 'rg --files'

source ~/.config/fish/platform_config/$MACHINE_TYPE.fish

if status is-interactive
  mise activate fish | source
else
  mise activate fish --shims | source
end
