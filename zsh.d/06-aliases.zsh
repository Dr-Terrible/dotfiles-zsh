# Wrap these commands for interactive use to avoid accidental overwrites
rm() { command rm -i "$@"; }
cp() { command cp -i "$@"; }
mv() { command mv -i "$@"; }

# Coloured output
alias -g dir="dir --color=auto"
alias -g vdir="vdir --color=auto"
if command -V grep >/dev/null 2>&1; then
	alias -g grep="grep --color=auto"
	alias -g fgrep="fgrep --color=auto"
	alias -g egrep="egrep --color=auto"
fi
if command -V less >/dev/null 2>&1; then
	alias -g less="less -R" # Make less accept colour codes and re-output them
fi

# Some useful defaults for common commands
alias -g lf="ls -lAFpZ --group-directories-first --color=auto"

# Some useful aliases to append
alias -g C='| wc -l'
alias -g D="DISPLAY=:0.0"
alias -g DN=/dev/null
alias -g NS='| sort -n'
alias -g NUL="> /dev/null 2>&1"
alias -g S='| sort'
alias -g T='| tail'
alias -g US='| sort -u'
