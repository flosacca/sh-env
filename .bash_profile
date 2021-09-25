if [ -n "$LOAD_TMUX" ]; then
  unset LOAD_TMUX
  if [ -z "$TMUX" ] && [ -x "$(command -v tmux)" ]; then
    exec tmux
  fi
fi

# The default .profile is not loaded if this file presents.
if [ -f "$HOME/.profile" ]; then
  . "$HOME/.profile"
fi
