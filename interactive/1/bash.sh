[ "$shell_type" = bash ] || return 0

case ${PS1-} in
  *'#'*)
    # Someone has detected elevated privileges and set the prompt char in PS1.
    # Preserve that prompt char.
    _prompt_char='#';;
  *)
    # Let bash determine the prompt char.
    _prompt_char='\$';;
esac

# In the basic case, show only the working directory and a prompt char.
PS1='\[\e[1;34m\]\w\[\e[m\]'$_prompt_char' '

# Show also user@hostname in a remote shell.
PS1=${SSH_CLIENT:+'\[\e[1;32m\]\u@\h\[\e[m\]:'}$PS1

# Indicate MSYS environment.
PS1=${MSYSTEM:+'\[\e[1;35m\][$MSYSTEM]\[\e[m\] '}$PS1

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
