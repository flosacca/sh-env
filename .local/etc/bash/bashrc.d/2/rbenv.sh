[ -x "$(command -v rbenv)" ] || return

. "$HOME/.rbenv/completions/rbenv.bash"

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
