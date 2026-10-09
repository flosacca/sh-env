# Stop less from generating ~/.lesshst
export LESSHISTFILE=-

# Create a configuration file for less if there is not already one.
if [ -z "${LESSKEY+x}" ] &&
    [ -z "${LESSKEYIN+x}" ] &&
    [ ! -e ~/.less ] &&
    [ ! -e ~/.lesskey ] &&
    command -v less >/dev/null 2>&1
  then
  # The tilde expansion is performed under variable assignments while not
  # inside double quotes.
  _config_home=${XDG_CONFIG_HOME:-~/.config}
  [ -e "$_config_home" ] || mkdir -p "$_config_home"

  _lesskey_source() {
    # Replace d/u/f/b with j/k/u/i. j/k are Vim-style keybindings, whereas u/i
    # are the keys immediately above j/k.
    printf '%s\n' \
      '#command' \
      'j forw-scroll' \
      'k back-scroll' \
      'u forw-screen' \
      'i back-screen'
  }

  # lesskey(1) is required in the versions of less prior to 582, but deprecated
  # in later versions. Use it only when it exists.
  if command -v lesskey >/dev/null 2>&1; then
    LESSKEY=$_config_home/less
    export LESSKEY
    if [ ! -e "$LESSKEY" ]; then
      _lesskey_source | lesskey - 2>/dev/null
    fi
  else
    LESSKEYIN=$_config_home/lesskey
    export LESSKEYIN
    if [ ! -e "$LESSKEYIN" ]; then
      _lesskey_source > "$LESSKEYIN"
    fi
  fi

  unset _config_home
  unset -f _lesskey_source
fi
