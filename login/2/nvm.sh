NVM_DIR=~/.nvm

if [ ! -d "$NVM_DIR" ]; then
  NVM_DIR=${XDG_DATA_HOME:-~/.local/share}/nvm
fi

if [ ! -d "$NVM_DIR" ]; then
  unset NVM_DIR
  return 0
fi

# The original initialization line does this exporting, though I do not think
# it is really necessary, because nvm is a shell function that is executed in
# the current shell context.
export NVM_DIR

_ref=default
while [ -f "$NVM_DIR/alias/$_ref" ]; do
  case $shell_type in
    bash|zsh)
      _ref=$(< "$NVM_DIR/alias/$_ref")  # much faster
      ;;
    *)
      _ref=$(cat -- "$NVM_DIR/alias/$_ref")
      ;;
  esac
done
if [ "$_ref" != default ]; then
  prepend_path "$NVM_DIR/versions/node/$_ref/bin"
fi
unset _ref
