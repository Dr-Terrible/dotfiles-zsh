 # avoid overlapping the default history-search-forward binding
setopt NO_FLOW_CONTROL

# Load keyboard mapping.
# TODO: add instructions about how to generate ~/.zkbd/xterm-256color-:0
# TODO: make the key mapping dependent on the hostname/os rather than $TERM
KEYMAPPING_DIR="${ZSHD_DIR}/zkbd/"
KEYMAP_FILE="${TERM}-${${DISPLAY:t}:-${VENDOR}-${OSTYPE}}"
if [ -r "${KEYMAPPING_DIR}"/${KEYMAP_FILE} ]; then
	. "${KEYMAPPING_DIR}"/${KEYMAP_FILE}
else
	# NOTE: if there is a missing key-mapping for a particular combination
	# of $TERM and $OSTYPE, then it is wise to pre-load the zkbd module so it
	# will be already at hand when necessary.
	autoload -Uz zkbd
fi

# Key binding for ZLE
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"    overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"      backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

# Magic space
bindkey ' ' magic-space
