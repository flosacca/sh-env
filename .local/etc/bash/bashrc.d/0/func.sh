is_bash() {
  [ "${BASH_VERSION-}" ]
}

is_zsh() {
  [ "${ZSH_VERSION-}" ]
}
