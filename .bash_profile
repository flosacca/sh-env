if [ -n "$LOAD_TMUX" ]; then
  unset LOAD_TMUX
  if [ -z "$TMUX" ] && [ -x "$(command -v tmux)" ]; then
    exec tmux
  fi
fi

umask 022

if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi
