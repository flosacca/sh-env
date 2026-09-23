g() {
  for _arg; do
    case $_arg in
      --) break;;
      --*) ;;
      -*r*)
        set -- --exclude-dir=.git "$@"
        break
        ;;
    esac
  done
  unset _arg
  command grep --color=auto "$@"
}

alias grep=g

mkcd() {
  mkdir -p -- "$@" && cd -- "$1"
}

pp() {
  printf '%s\n' "$PATH" | tr : '\n'
}

vman() {
  # Use Vim as the pager of man page, but let Vim read a temporary file
  # instead of stdin.
  (
    # Prefer using a milliseconds timestamp as the unique name of the
    # temporary file over the usual way, because seeing the random letters is
    # distractive.
    # Vim has a man page syntax and applies it when encountering the extension
    # of ".man".
    tmpfile=/tmp/$(date +%s%3N 2>/dev/null || mktemp -u XXXXXXXX).man

    columns=${MANWIDTH:-$(command -v tput >/dev/null 2>&1 && tput cols)}
    columns=${columns:-${COLUMNS-}}

    # Assume the columns used by the line number is at most 6. With the
    # default 'numberwidth' in Vim, this happens when the count of lines is
    # between 1 and 99999.
    columns=${columns:+$(expr "$columns" - 6)}

    # man(1) leaves extra spaces by passing certain options to groff with a
    # line length slightly smaller than the configured or detected width, i.e.
    # $MANWIDTH, $COLUMNS or the width from the terminal. The exact line
    # length was computed in an unobvious way, which has also changed across
    # versions.
    # The following groff options are added with the exact demand to override
    # the options added by man(1). These options are specific to groff and the
    # case where nroff is not groff is not considered.
    groff_opts=${columns:+-rLL=${columns}n -rLT=${columns}n}

    # man(1) may report errors to stderr, which are however by default
    # suppressed when a pager is used.
    if MANROFFOPT="$groff_opts" man "$@" > "$tmpfile"; then
      # `vim -R` sets read-only mode, which is deliberately chosen over
      # unsetting 'modifiable' as `vim -M` does, to allow any temporary
      # editing.
      vim -R "$tmpfile"
      status=$?  # exit status of vim
    else
      status=$?  # exit status of man
    fi

    # Always clean up the temporary file.
    rm -f "$tmpfile"

    # Exit the subshell with the status of the effective last command.
    exit "$status"
  )
}

vinfo() {
  # GNU Info is for reading more detailed documentation for some GNU tools.
  # I am not willing to adapt to the Info reader, so let me stay in Vim.
  (
    tmpfile=/tmp/info-$(date +%s%3N 2>/dev/null || mktemp -u XXXXXXXX).txt
    info --subnodes "$@" > "$tmpfile"
    [ -s "$tmpfile" ] && vim -R "$tmpfile"
    rm -f "$tmpfile"
  )
}

alias less='less -R'

lt0() {
  for _arg; do
    shift
    case $_arg in
      /) ;;
      */)
        if [ -d "$_arg" ]; then
          _arg=${_arg%/}
        fi
        ;;
    esac
    set -- "$@" "$_arg"
  done
  unset _arg
  tree -a -I .git -C "$@" | LESS="${LESS--SFX}" command less -RU
}

alias lt1='lt0 -L 1'
alias lt2='lt0 -L 2'
alias lt3='lt0 -L 3'
alias lt4='lt0 -L 4'
alias lt=lt2

alias ls='ls --color=auto'

alias l='ls_l -Fh'
alias ll='ls_l -aFh'

_ls_l_filter() {
  command grep -v '^total .*[^:]$'
}

ls_l() {
  [ -t 1 ] && set -- --color=always "$@"
  filter=_ls_l_filter \
    _filter_with_status ls -l \
      --quoting-style="${LS_QUOTING_STYLE:-shell-escape}" \
      "$@"
}

curln() {
  curl "$@" && printf '\n'
}

alias gs='git status'
alias gl='git log --oneline -30'
alias gp='git log -p -1 --oneline'
alias gco='git checkout'

_git_is_commit() {
  git rev-parse --verify "$1^{commit}" >/dev/null 2>&1
}

gd() {
  # Simplify invoking `git diff` between two adjacent commits:
  # - `gd N [COMMIT]` for `git diff COMMIT~N COMMIT~<N-1>`, where COMMIT
  #   defaults to HEAD.
  # - `gd 0` for `git diff --cached`.
  # - fall back to a normal `git diff` otherwise.
  # This is simliar to `git log -p -1 COMMIT~<N-1>`, which is already
  # abbreviated to `gp` in the above. However, `gd` is by default relative to
  # HEAD and also works when there is not yet a commit.
  if awk 'BEGIN { exit ARGV[1] !~ /^[0-9]{1,3}$/ }' "${1-}"; then
    _num=$1
    shift
    if [ "$_num" = 0 ]; then
      set -- --cached "$@"
    else
      if _git_is_commit "${1-}"; then
        set -- "$1~$_num" "$@"
      else
        set -- "HEAD~$_num" "HEAD~$((_num - 1))" "$@"
      fi
    fi
    unset _num
  fi
  git diff "$@"
}
