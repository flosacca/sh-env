load() {
  local p
  for p in "$HOME/.local/etc/bash/$1"{/*,}/*.sh; do
    [ -f "$p" ] && . "$p"
  done
}

shopt -q login_shell && load profile.d

if [[ $- = *i* ]]; then
  load bashrc.d
  unset load
else
  unset load
  return
fi

shopt -s globstar

alias s=/d/dev/repo/ssh-helper/ssh.sh

alias inspect='ruby -e "p ARGV"'
