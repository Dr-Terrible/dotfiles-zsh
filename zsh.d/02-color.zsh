# Let's have some colors first
autoload -U colors && colors

# 256 color mode
#export TERM="xterm-256color"

# Set up LS_COLORS environment variable
if command -V dircolors >/dev/null 2>&1; then
	eval "$( dircolors -b )"
fi