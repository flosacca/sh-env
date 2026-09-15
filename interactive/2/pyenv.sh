[ -x "$(command -v pyenv)" ] || return

. ~/.pyenv/completions/pyenv."$shell_type"

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
