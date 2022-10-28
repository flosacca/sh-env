alias pc=proxychains4

alias grep='grep --color=auto'

mkcd() {
  mkdir -p -- "$@" && cd -- "$1"
}

clh() {
  if is_bash; then
    history -c
    history -w
  elif is_zsh; then
    rm -f "$HISTFILE"
  fi
}

clp() {
  find . -type d -name __pycache__ -exec rm -r {} +
}

vimman() {
  local p="/tmp/man.$(date +%s%3N).txt"
  man "$@" > "$p" && vim -R "$p"
  rm -f "$p"
}

pp() {
  tr : \\n <<< $PATH
}

curln() {
  curl "$@" && echo;
}

alias ls='ls --color=auto'

alias l='ls_l -Fh'
alias ll='ls_l -aFh'

ls_l() {
  local ls=(ls --quoting-style=shell-escape)
  if [ -t 1 ]; then
    ls+=(--color=always)
  fi
  _pipe_status "'grep' -v '^total .*[^:]$'" "${ls[@]}" -l "$@"
}

alias gs='git status'
alias gl='git log --oneline -30'

gd() {
  if [[ $1 =~ ^[0-9]{1,3}$ ]]; then
    if [ "$1" = 0 ]; then
      git diff --cached "${@:2}"
    else
      git diff "HEAD~$1" "HEAD~$(($1 - 1))" "${@:2}"
    fi
  else
    git diff "$@"
  fi
}

git-sync() {
  if [ -z "$(git status --porcelain)" ]; then
    git reset --hard @{u}
  else
    git status
  fi
}
