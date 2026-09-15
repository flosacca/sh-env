[ -d ~/.nvm ] || return

export NVM_DIR=~/.nvm

v=default
while [ -f "$NVM_DIR/alias/$v" ]; do
  v=$(< "$NVM_DIR/alias/$v")
done
if [ "$v" != default ]; then
  prepend_path "$NVM_DIR/versions/node/$v/bin"
fi
unset v
