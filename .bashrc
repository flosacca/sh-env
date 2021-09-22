if [[ $- != *i* ]]; then
  return
fi

for d in $(shopt -q login_shell && echo profile.d) bashrc.d; do
  for p in "$HOME/.local/etc/bash/$d"{/*,}/*.sh; do
    [ -f "$p" ] && . "$p"
  done
  unset p
done
unset d

shopt -s globstar

export RUBYLIB=/d/dev/repo/ruby-ext

alias s=/d/dev/repo/ssh-helper/ssh.sh
