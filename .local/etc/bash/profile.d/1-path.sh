prepend_path() {
  local p
  for p; do
    export PATH="$p:$PATH"
  done
}

append_path() {
  local p
  for p; do
    export PATH="$PATH:$p"
  done
}

append_path /d/dev/repo/cli-utils{,/bash}
