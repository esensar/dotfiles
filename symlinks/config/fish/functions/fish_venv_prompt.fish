# Taken from https://github.com/oh-my-fish/theme-agnoster/blob/4c5518c89ebcef393ef154c9f576a52651400d27/functions/fish_prompt.fish#L181
# Removed Nix support
function fish_venv_prompt -d "Display Python virtual environment"
  set envs

  if test "$CONDA_DEFAULT_ENV"
    set envs $envs "conda[$CONDA_DEFAULT_ENV]"
  end

  if test "$VIRTUAL_ENV"
    set py_env (basename $VIRTUAL_ENV)
    set envs $envs "py[$py_env]"
  end

  if test "$envs"
    echo -n -s (set_color $___fish_venv_prompt_color_bg) (set_color $___fish_vent_prompt_color_fg) " " (string join " " $envs)
  end
end
