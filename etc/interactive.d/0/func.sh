_pipe_status() {
  (
    (
      (set +e; "${@:2}"; echo "$?" >&4) | eval "$1" >&3
    ) 4>&1 | (IFS= read s; exit "$s")
  ) 3>&1
}
