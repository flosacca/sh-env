colon_list() {
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

prepend_path() {
  PATH=$(colon_list "$@" "$PATH")
  export PATH
}

append_path() {
  PATH=$(colon_list "$PATH" "$@")
  export PATH
}
