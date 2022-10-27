[ -x "$(command -v pyenv)" ] || return

is_bash && . ~/.pyenv/completions/pyenv.bash
is_zsh && . ~/.pyenv/completions/pyenv.zsh

pyenv() {
  case ${1-} in
  shell|rehash)
    eval "$(command pyenv "sh-$1" "${@:2}")"
    ;;
  *)
    command pyenv "$@"
    ;;
  esac
}
