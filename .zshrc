# .zshrc

# Test for an interactive shell.
# There is no need to set anything past this point for scp and rcp.
# It's important to refrain from outputting anything in those cases.
if [[ $- != *i* ]] ; then
        # Shell is non-interactive. Be done now!
        return
fi

# TODO: investigate why umask from ~/.zprofile is ignored by newer ZSH versions.
umask 0077

# Put your fun stuff here.
# ------------------------

# Dynamic load all the module set-ups, and helper functions.
if [ -d "${ZSHD_DIR}" ]; then
	for script in "${ZSHD_DIR}"/*.zsh ; do
		[ -r "${script}" ] && . "${script}"
	done
	unset script
fi

# Load direnv helper functions
if command -v direnv >/dev/null 2>&1; then
	eval "$( direnv hook zsh )"
fi

# Compile everything
autoload -Uz zrecompile
zrecompile -p \
	-R "${ZDOTDIR}"/.zlogin -- \
	-R "${ZDOTDIR}"/.zlogout -- \
	-R "${ZDOTDIR}"/.zprofile -- \
	-R "${ZDOTDIR}"/.zshrc -- \
	-M "${ZDOTDIR}"/.zcompdump

autoload -Uz zmv
autoload -Uz zcalc
