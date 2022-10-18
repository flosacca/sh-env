[ -x "$(command -v rbenv)" ] || return

is_bash && . "$HOME/.rbenv/completions/rbenv.bash"
is_zsh && . "$HOME/.rbenv/completions/rbenv.zsh"

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
