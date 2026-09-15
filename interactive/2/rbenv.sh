[ -x "$(command -v rbenv)" ] || return

. ~/.rbenv/completions/rbenv."$shell_type"

rbenv() {
  case ${1-} in
  shell|rehash)
    eval "$(command rbenv "sh-$1" "${@:2}")"
    ;;
  *)
    command rbenv "$@"
    ;;
  esac
}
