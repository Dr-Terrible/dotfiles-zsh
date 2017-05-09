# .zshrc

# Test for an interactive shell.
# There is no need to set anything past this point for scp and rcp.
# It's important to refrain from outputting anything in those cases.
if [[ $- != *i* ]] ; then
        # Shell is non-interactive. Be done now!
        return
fi


# Put your fun stuff here.
# ------------------------

# Dynamic load all the module set-ups, and helper functions.
if [ -d "${ZSHD_DIR}" ]; then
	for script in "${ZSHD_DIR}"/*.zsh ; do
		[ -r "${script}" ] && . "${script}"
	done
fi

autoload -Uz zmv
autoload -Uz zcalc
