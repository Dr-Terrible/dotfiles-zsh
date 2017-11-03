# Wrap these commands for interactive use to avoid accidental overwrites
rm() { command rm -i "$@"; }
cp() { command cp -i "$@"; }
mv() { command mv -i "$@"; }

# Coloured output
if [ -n "${LS_COLORS}" ]; then
	dir() { command dir --color=auto "$@"; }
	vdir() { command vdir --color=auto "$@"; }

	if command -pv grep >/dev/null 2>&1; then
		grep() { command grep --color=auto "$@"; }
		fgrep() { command fgrep --color=auto "$@"; }
		egrep() { command egrep --color=auto "$@"; }
	fi

	# Make less accept colour codes and re-output them
	if command -pv less >/dev/null 2>&1; then
		less() { command less -RMJqs --shift 5 "$@"; }
	fi
fi

# Some useful defaults for common commands
lf() { command ls -lHAFpZ --group-directories-first --sort=extension --color=auto "$@" | tail -n +2; }

# Some useful aliases to append at the command line
[ -n "${DISPLAY}" ] && alias -g D="DISPLAY=${DISPLAY}"
alias -g C='| wc -l'
alias -g DN=/dev/null
alias -g NS='| sort -n'
alias -g NUL="> /dev/null 2>&1"
alias -g S='| sort'
alias -g T='| tail'
alias -g US='| sort -u'
