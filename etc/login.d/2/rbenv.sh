[ -d "$HOME/.rbenv" ] || return

prepend_path "$HOME/.rbenv/bin"
prepend_path "$HOME/.rbenv/shims"
