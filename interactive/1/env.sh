export EDITOR=vim

# Export LS_COLORS from the builtin database of dircolors(1).
# $LS_COLORS customizes the colors used by ls(1) and allows to set colors
# according to file extensions. The default output of dircolors identifies
# common file extensions of archives, images and audios.
# Having $LS_COLORS set also makes tree(1) to use colors on terminal output,
# like `ls --color=auto`.
eval "$(dircolors -b 2>/dev/null)"
