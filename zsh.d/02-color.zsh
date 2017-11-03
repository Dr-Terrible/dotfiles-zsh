# Let's have some colours first
autoload -Uz colors
colors

# Set up LS_COLORS environment variable
if command -pv dircolors >/dev/null 2>&1; then
	eval "$( dircolors -b )"
fi