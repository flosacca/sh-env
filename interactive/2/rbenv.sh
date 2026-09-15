command -v rbenv >/dev/null 2>&1 || return 0

_load ~/.rbenv/completions/rbenv."$shell_type"

rbenv() {
  case ${1-} in
  shell|rehash)
    eval "$(
      subcmd=sh-$1
      shift
      command rbenv "$subcmd" "$@"
    )"
    ;;
  *)
    command rbenv "$@"
    ;;
  esac
}
