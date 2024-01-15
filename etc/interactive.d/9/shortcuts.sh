g() {
  local arg
  for arg; do
    case $arg in
      --) break;;
      --*) ;;
      -*r*) set -- --exclude-dir=.git "$@";;
    esac
  done
  command grep --color=auto "$@"
}

alias grep=g

alias rm='rm --interactive=never'

mkcd() {
  mkdir -p -- "$@" && cd -- "$1"
}

clh() {
  case $shell_type in
    bash) history -c && rm -f ~/.bash_history;;
    zsh) rm -f "$HISTFILE";;
  esac
}

clp() {
  find . -type d -name __pycache__ -exec rm -r {} +
}

vman() {
  local p
  p=/tmp/man.$(date +%s%3N).txt
  man "$@" > "$p" && vim -R "$p"
  rm -f "$p"
}

pp() {
  tr : \\n <<< "$PATH"
}

curln() {
  curl "$@" && echo;
}

alias pc=proxychains4

alias ls='ls --color=auto'

alias l='ls_l -Fh'
alias ll='ls_l -aFh'

_ls_l_filter() {
  command grep -v '^total .*[^:]$'
}

ls_l() {
  [ -t 1 ] && set -- --color=always "$@"
  filter=_ls_l_filter _filter_with_status \
    ls -l \
    --quoting-style="${LS_QUOTING_STYLE:-shell-escape}" \
    "$@"
}

alias gs='git status'
alias gl='git log --oneline -30'
alias gco='git checkout'

_git_is_commit() {
  git rev-parse --verify "$1^{commit}" >/dev/null 2>&1
}

gd() {
  local n
  if [[ $1 =~ ^[0-9]{1,3}$ ]]; then
    n=$1
    shift
    if [ "$n" = 0 ]; then
      set -- --cached "$@"
    else
      if _git_is_commit "$1"; then
        set -- "$1~$n" "$@"
      else
        set -- "HEAD~$n" "HEAD~$((n - 1))" "$@"
      fi
    fi
  fi
  git diff "$@"
}

git-sync() {
  if [ -z "$(git status --porcelain)" ]; then
    git reset --hard '@{u}'
  else
    git status
  fi
}
