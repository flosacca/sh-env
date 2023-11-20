[ "${BASH_VERSION-}${ZSH_VERSION-}" ] || return

load() {
  [ -f "$1" ] && . "$1"
}

_puts() {
  printf '%s\n' "$@"
}

_real_dir() {
  _puts "$(dirname "$(readlink -f "$1")")"
}

_set_vars() {
  if [ "${BASH_VERSION-}" ]; then
    shell_type=bash
    base_dir=$(_real_dir "$BASH_SOURCE")
  elif [ "${ZSH_VERSION-}" ]; then
    shell_type=zsh
    base_dir=${${(%):-%x}:P:h}
  fi
}

_is_login() {
  case $shell_type in
    bash) shopt -q login_shell;;
    zsh) [[ -o login ]];;
  esac
}

_load_dir() {
  local p
  for p in "$base_dir/etc/$1"/*/*.sh; do
    . "$p" || :
  done
}

_unset_all() {
  unset base_dir
  unset -f _puts _real_dir _set_vars _is_login _load_dir _unset_all
}

_set_vars
if _is_login; then
  _load_dir login.d
fi
if [[ $- = *i* ]]; then
  _load_dir interactive.d
fi
_unset_all
