[ -d ~/.nvm ] || return 0

NVM_DIR=~/.nvm

# The original initialization line does this exporting, though I do not think
# it is really necessary, as nvm is a shell function that is executed in the
# current shell context.
export NVM_DIR

_ref=default
while [ -f "$NVM_DIR/alias/$_ref" ]; do
  _ref=$(cat "$NVM_DIR/alias/$_ref")
done
if [ "$_ref" != default ]; then
  prepend_path "$NVM_DIR/versions/node/$_ref/bin"
fi
unset _ref
