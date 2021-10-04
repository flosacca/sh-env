alias c=clear
alias pc=proxychains4

mkcd() {
  mkdir -p "$@" && cd "$1"
}

clh() {
  history -c && history -w
}

clp() {
  find . -type d -name __pycache__ | xargs -d'\n' rm -r
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

unalias l 2>/dev/null
unalias ll 2>/dev/null

l() {
  if [ $# -eq 0 ]; then
    [ -n "$(ls)" ] && ls -ldFh *
  else
    ls -lFh "$@"
  fi
}

ll() {
  if [ $# -eq 0 ]; then
    [ -n "$(ls)" ] && ls -ldFh * .* || ls -ldFh .*
  else
    ls -laFh "$@"
  fi
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
      git diff "$@" HEAD~$n HEAD~$(($n - 1))
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
