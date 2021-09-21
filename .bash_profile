if [[ -n "$USE_TMUX" && -z "$TMUX" ]]; then
  exec tmux
fi

# The default .profile is not loaded if this file presents.
if [ -f "$HOME/.profile" ]; then
  . "$HOME/.profile"
fi
