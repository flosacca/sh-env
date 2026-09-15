[ -n "$NVM_DIR" ] || return 0

nvm() {
  unset -f nvm
  . "$NVM_DIR/nvm.sh"
  nvm "$@"
}

case $shell_type in
  bash|zsh)
    . "$NVM_DIR/bash_completion";;
esac
