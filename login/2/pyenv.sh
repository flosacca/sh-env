[ -d ~/.pyenv ] || return 0

prepend_path ~/.pyenv/bin
prepend_path ~/.pyenv/shims
