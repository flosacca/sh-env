export EDITOR=vim

# Export LS_COLORS from the builtin database of dircolors(1).
# $LS_COLORS customizes the colors used by ls(1) and allows to set colors
# according to file extensions. The default output of dircolors identifies
# common file extensions of archives, images and audios.
# Having $LS_COLORS set also makes tree(1) to use colors on terminal output,
# like `ls --color=auto`.
eval "$(dircolors -b 2>/dev/null)"

export PYTHONDONTWRITEBYTECODE=1

NPM_CONFIG_CACHE=${XDG_CACHE_HOME:-~/.cache}/npm
export NPM_CONFIG_CACHE

BUNDLE_USER_CACHE=${XDG_CACHE_HOME:-~/.cache}/bundle
export BUNDLE_USER_CACHE
BUNDLE_USER_CONFIG=${XDG_CONFIG_HOME:-~/.config}/bundle/config
export BUNDLE_USER_CONFIG
