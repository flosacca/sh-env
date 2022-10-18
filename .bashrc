[ "${BASH_VERSION-}${ZSH_VERSION-}" ] || return

load_dir() {
  local s p
  s=$(pwd)
  for p in "$HOME/.local/etc/bash/$1"/*/*.sh; do
    if [ -f "$p" ]; then
      cd "$(dirname "$p")"
      . "$p"
    fi
  done
  cd "$s"
}

is_login() {
  if [ "${BASH_VERSION-}" ]; then
    shopt -q login_shell
  else
    [[ -o login ]]
  fi
}

finish() {
  unset -f load_dir is_login finish
}

is_login && load_dir profile.d

if [[ $- = *i* ]]; then
  load_dir bashrc.d
  finish
else
  finish
  return
fi
