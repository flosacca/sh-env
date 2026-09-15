[ "$shell_type" = bash ] || return 0

# The prompt shows the working directory and a prompt character.
PS1='\[\e[1;34m\]\w\[\e[m\]\$ '
if [ -n "${SSH_CLIENT-}" ]; then
  PS1='\[\e[1;32m\]\u@\h\[\e[m\]:'$PS1
fi

# Turn off the vulnerable history expansion.
set +o histexpand

# Stop caching executable paths, which is generally unexpected while improving
# little performance.
set +o hashall

# extglob enables regex-like glob patterns. bash-completion sets this option
# and relies on it to work, so I have to keep it though I do not want it.
# shopt -u extglob

# Report error on empty globbing, as zsh does. It guards against unintended
# filename expansions.
shopt -s failglob

# Make the pattern "**" match file entries under recursive subdirectories. It
# cannot match a partial file entry, that is, "**.sh" does not work while
# "**/*.sh" does.
# Note that "**" is a valid pattern even if this option is not set, where it
# is equivalent to "*", which may bring confusion.
shopt -s globstar
