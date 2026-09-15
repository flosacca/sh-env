if [ -n "${BASH_VERSION-}" ]; then
  shell_type=bash
elif [ -n "${ZSH_VERSION-}" ]; then
  shell_type=zsh
else
  shell_type=sh
fi

if [ -z "${sh_env_dir-}" ]; then
  case $shell_type in
    bash)
      sh_env_dir=$(
        self=${BASH_SOURCE[0]}
        if command -v realpath >/dev/null 2>&1; then
          self=$(realpath -- "$self")
        elif command -v readlink >/dev/null 2>&1; then
          self=$(readlink -f -- "$self")
        fi
        if command -v dirname >/dev/null 2>&1; then
          dirname -- "$self"
        else
          printf '%s\n' "${self%/*}"
        fi
      )
      ;;
    zsh)
      sh_env_dir=${${(%):-%x}:P:h}
      ;;
    *)
      # unable to locate the base directory
      return 1;;
  esac
fi

_login_shell() {
  case $shell_type in
    bash)
      shopt -q login_shell;;
    zsh)
      [[ -o login ]];;
    *)
      # assume true since only login shell loads profile
      ;;
  esac
}

_load() {
  for _script; do
    if [ -r "$_script" ]; then
      . "$_script"
    fi
  done
  unset _script
}

if _login_shell; then
  _load "$sh_env_dir"/login/*/*.sh
fi

case $- in (*i*)
  _load "$sh_env_dir"/interactive/*/*.sh
esac

unset -f _login_shell _load

unset sh_env_dir

# "$shell_type" is not unset
# unset shell_type
