_filter_with_status() {
  (
    (
      (set +e; "$@"; echo "$?" >&4) | "$filter" >&3
    ) 4>&1 | (IFS= read s; exit "$s")
  ) 3>&1
}
