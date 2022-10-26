# Construct colon-separated list
csl_cons() {
  awk 'BEGIN {
    for (i = 1; i < ARGC; ++i) {
      n = split(ARGV[i], a, ":")
      for (j = 1; j <= n; ++j) {
        if (!c[a[j]]++) {
          r[++r[0]] = a[j]
        }
      }
    }
    for (i = 1; i <= r[0]; ++i) {
      printf "%s%s", i == 1 ? "" : ":", r[i]
    }
    exit
  }' "$@"
}

add_env() {
  if ! [[ ${1-}:${2-} =~ ^[LR]:[a-zA-Z0-9_]+$ ]]; then
    return 1
  fi
  local v a
  eval "v=\${$2-}"
  if [ "$1" = L ]; then
    a=("${@:3}" "$v")
  else
    a=("$v" "${@:3}")
  fi
  export "$2=$(csl_cons "${a[@]}")"
}

prepend_path() {
  add_env L PATH "$@"
}

append_path() {
  add_env R PATH "$@"
}
