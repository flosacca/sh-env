[ -n "$NVM_DIR" ] || return

nvm() {
  unset -f nvm
  . "$NVM_DIR/nvm.sh"
  nvm "$@"
}

. "$NVM_DIR/bash_completion"
