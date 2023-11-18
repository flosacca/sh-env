csl() {
  # colon-separated list
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

env_list_add() {
  local pos name value
  pos=${1-}
  name=${2-}
  if ! [[ $pos:$name =~ ^[LR]:[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
    return 1
  fi
  shift 2
  eval "value=\${$name-}"
  if [ "$pos" = L ]; then
    set -- "$@" "$value"
  else
    set -- "$value" "$@"
  fi
  value=$(csl "$@")
  export "$name=$value"
}

prepend_path() {
  env_list_add L PATH "$@"
}

append_path() {
  env_list_add R PATH "$@"
}
