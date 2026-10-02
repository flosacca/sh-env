RBENV_ROOT=~/.rbenv

if [ ! -d "$RBENV_ROOT" ]; then
  RBENV_ROOT=${XDG_DATA_HOME:-~/.local/share}/rbenv

  if [ ! -d "$RBENV_ROOT" ]; then
    unset RBENV_ROOT
    return 0
  fi

  export RBENV_ROOT
fi

prepend_path "$RBENV_ROOT/bin" "$RBENV_ROOT/shims"
