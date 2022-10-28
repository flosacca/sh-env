# sh-env

General settings for bash or zsh.

## Usage

Clone the repository somewhere and add `. <repo>/init.sh` to your `bashrc` or `zshrc`.

## Features

- `l` to invoke `ls -lFh`, without the disturbing `total ...:` line
  - also `ll` for additional `-a`
- `mkcd` to `cd` after `mkdir`
- `vimman` to open man page in vim
- `pp` to print `$PATH` by line
- `gd` to invoke `git diff` with ease:
  - `gd 0` for `git diff --cached`
  - `gd <n>` for `git diff HEAD~<n> HEAD~<n-1>`
  - normal `git diff` otherwise
- `gs` for `git status`
- `gl` for `git log --oneline -30`
- `$PATH` exporting without duplication even if sourced twice
- `rbenv` and `pyenv` support if available
- `nvm` support with on-demand initialization, while default `node` always usable
