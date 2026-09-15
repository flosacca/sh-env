command -v pyenv >/dev/null 2>&1 || return 0

_load ~/.pyenv/completions/pyenv."$shell_type"

pyenv() {
  case ${1-} in
  shell|rehash)
    eval "$(
      subcmd=sh-$1
      shift
      command pyenv "$subcmd" "$@"
    )"
    ;;
  *)
    command pyenv "$@"
    ;;
  esac
}
