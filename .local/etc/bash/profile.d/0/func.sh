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
  if ! [[ $1 = [LR] && $2 =~ ^[_[:alnum:]]+$ ]]; then
    return 1
  fi
  local a=$1 v=$2
  shift 2
  if eval '[[ ${'$v'+.} ]]'; then
    if [ $a = L ]; then
      eval 'set -- "$@" "$'$v'"'
    else
      eval 'set -- "$'$v'" "$@"'
    fi
  fi
  export "$v=$(csl_cons "$@")"
}

prepend_path() {
  add_env L PATH "$@"
}

append_path() {
  add_env R PATH "$@"
}
