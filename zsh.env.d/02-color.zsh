# Let's have some colours first
autoload -Uz colors
colors

# Set up LS_COLORS environment variable
if command -pv dircolors >/dev/null 2>&1; then
	eval "$( dircolors -b )"
fi


# @FUNCTION: man
# @DESCRIPTION:
#
# Colored man pages.
# Bold and blink text are blue while underlined text is green.
#
# termcap legend
# ks       make the keypad send commands
# ke       make the keypad send digits
# vb       emit visual bell
# mb       start blink
# md       start bold
# me       turn off bold, blink and underline
# so       start standout (reverse video)
# se       stop standout
# us       start underline
# ue       stop underline
#
function _man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;34m") \
		LESS_TERMCAP_md=$(printf "\e[1;34m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;47;33m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		man "$@";
}
