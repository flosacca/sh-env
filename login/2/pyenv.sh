PYENV_ROOT=~/.pyenv

if [ ! -d "$PYENV_ROOT" ]; then
  PYENV_ROOT=${XDG_DATA_HOME:-~/.local/share}/pyenv

  if [ ! -d "$PYENV_ROOT" ]; then
    unset PYENV_ROOT
    return 0
  fi

  export PYENV_ROOT
fi

prepend_path "$PYENV_ROOT/bin" "$PYENV_ROOT/shims"
