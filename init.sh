[ "${BASH_VERSION-}${ZSH_VERSION-}" ] || return

is_bash() {
  [ "${BASH_VERSION-}" ]
}

is_zsh() {
  [ "${ZSH_VERSION-}" ]
}

puts() {
  printf '%s\n' "$@"
}

load() {
  [ -f "$1" ] && . "$@"
}

real_dir() {
  puts "$(dirname "$(readlink -f "$1")")"
}

set_vars() {
  if is_bash; then
    shell_type=bash
    base_dir=$(real_dir "$BASH_SOURCE")
  elif is_zsh; then
    shell_type=zsh
    base_dir=${${(%):-%x}:A:h}
  fi
}

is_login() {
  case $shell_type in
    bash) shopt -q login_shell;;
    zsh) [[ -o login ]];;
  esac
}

load_dir() {
  local p
  for p in "$base_dir/etc/$1"/*/*.sh; do
    . "$p"
  done
}

unset_all() {
  unset shell_type base_dir
  unset -f puts load real_dir set_vars is_login load_dir unset_all
}

set_vars
if is_login; then
  load_dir login.d
fi
if [[ $- = *i* ]]; then
  load_dir interactive.d
fi
unset_all
