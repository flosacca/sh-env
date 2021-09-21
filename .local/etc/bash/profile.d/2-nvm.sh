export NVM_DIR="$HOME/.nvm"
if [ ! -f "$NVM_DIR/nvm.sh" ]; then
  unset NVM_DIR
  return
fi

nvm() {
  unset nvm
  . "$NVM_DIR/nvm.sh"
  nvm "$@"
}

. "$NVM_DIR/bash_completion"

v="$(cat "$NVM_DIR/alias/default")"
while [ -f "$NVM_DIR/alias/$v" ]; do
  v="$(cat "$NVM_DIR/alias/$v")"
done
prepend_path "$NVM_DIR/versions/node/$v/bin"
unset v
