alias grep='grep --color=auto'

alias pc=proxychains4

mkcd() {
  mkdir -p "$@" && cd "$1"
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
  local id=$(date +%s%3N)
  local p=/tmp/man.$id.txt
  man "$@" > $p && vim -R $p
  rm $p
}

pp() {
  tr : \\n <<< $PATH
}

alias ls='ls --color=auto'

alias l='ls_l -Fh'
alias ll='ls_l -aFh'

ls_l() {
  local ls=(ls --quoting-style=shell-escape)
  if [ -t 1 ]; then
    ls+=(--color=always)
  fi
  "${ls[@]}" -l "$@" | grep -v '^total .*[^:]$'
}

alias gs='git status'
alias gl='git log --oneline -30'

gd() {
  if [[ $1 =~ ^[0-9]{1,3}$ ]]; then
    local n=$1
    shift
    if [ $n -eq 0 ]; then
      git diff --cached "$@"
    else
      git diff HEAD~$n HEAD~$(($n - 1)) "$@"
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
