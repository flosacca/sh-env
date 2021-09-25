[ -d "$HOME/.nvm" ] || return

export NVM_DIR="$HOME/.nvm"

v=$(<"$NVM_DIR/alias/default")
while [ -f "$NVM_DIR/alias/$v" ]; do
  v=$(<"$NVM_DIR/alias/$v")
done
prepend_path "$NVM_DIR/versions/node/$v/bin"
unset v
