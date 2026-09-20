# sh-env

General settings for bash, zsh or POSIX shells.

## Usage

Clone the repository somewhere and source the `init.sh` in a proper startup file.

For example, run
```
git clone https://github.com/flosacca/sh-env ~/.local/share/sh-env
```
and put this line into `~/.bashrc`
```
. ~/.local/share/sh-env/init.sh
```

### Related concepts and details

Roughly speaking, the first shell for a specific user is usually a login shell, while subsequent subshells are not.
For interactive use, the first shell is an interactive login shell, and subsequent shells are interactive non-login shells.

Shells usually have two types of startup files: `*profile` (or `*login`) is for login shells, regardless of whether they are interactive or not. `*rc` is for interactive shells.
These are two distinct ideas that lie behind this. The user environment should be set up once on login, which is what "login" means, with the user's "profile". In the other hand, there may be some commands you'd like to always run before your interactive use. These commands are put in "rc", which literally means "run commands".

Where things go complicated is that, interactive login shells may not load `*rc`. POSIX shells don't even have a "rc" file. They only look up for `/etc/profile` and `~/.profile` for login shells. Bash has `/etc/bash.bashrc` and `~/.bashrc`, but only loads them for interactive *non-login* (or remote-login) shells. To make bash also load `bashrc`s for interactive login shells, the `profile`s usually contain some code that sources `bashrc`s when run interactively. In contrast, zsh *does* load `~/.zshrc` for interactive login shells.

The way I recommend is that:
- for bash, create a `~/.bash_profile` that contains only the line `. ~/.bashrc`, and put all stuffs into `~/.bashrc`. Perform the login check inside `bashrc`.
- for zsh, simply do anything within `~/.zshrc`.

Particularly for this repository, put the setup line in `~/.bashrc` or `~/.zshrc`. It runs the corresponding login parts and interactive parts on itself.

For POSIX shells, the setup has to however be modified to:
```sh
# ~/.profile
sh_env_dir=~/.local/share/sh-env  # or a custom location
. "$sh_env_dir/init.sh"
```
The repository directory has to be stored explicitly into a variable, or the script has no way to determine where it reside. Also, POSIX shells won't load the startup files for interactive non-login shells.

### Design

`init.sh` sources `login/*/*.sh` if run as a login shell, and then sources `interactive/*/*.sh` if run interactively. These scripts are sourced in the order of the expanded glob, which should follow the apparent order when the names contain exactly one leading digit.
You may put any additional scripts in these locations to make them to be sourced on the startup, and you may put non-portable code into script files whose names start with an underscore, as `_*.sh` is `gitignore`d.

## Defined shortcuts

- `l` for `ls -lFh`, without the disturbing `total ...:` line. also, `ll` adds `-a`
- `g` for `grep --exclude-dir=.git`
- `mkcd` for `cd` after `mkdir`
- `pp` to print `$PATH` by line
- `vman` to open a man page in Vim
- `lt[n]` for `tree -L [n] -I .git -C | less -R`. `lt` is `lt2`
- `gs` for `git status`
- `gl` for `git log --oneline -30`

## Other features

The entries in `$PATH` is always deduplicated when any path is added. It won't contain any duplication even if the startup files are sourced more than once.

It sets up a configuration file for the less pager if there isn't one. Setting `$LESSKEY` or `$LESSKEYIN` (even with an empty value) prevents this behavior.

It detects some version managers and sets them up automatically, as the setup lines they would add in the startup files. The supported version managers are:
- rbenv
- pyenv
- nvm
- cargo

Among above, nvm is designed as a heavy shell function, which is too slow to be loaded on every startup. In contrast, we load the main shell function on demand, but find the default `node` and set up `$PATH` in advance to make `node` usable regardless of nvm's state.
