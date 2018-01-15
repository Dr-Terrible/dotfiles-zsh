# .zshrc

# Test for an interactive shell.
# There is no need to set anything past this point for scp and rcp.
# It's important to refrain from outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive. Be done now!
	return
fi

case ${OSTYPE} in
	solaris*) ;;
	linux*) ;;
	darwin*) ;;
	bsd*) ;;
	*)
		printf "OS '${OSTYPE}' not supported! Aborting.\n"
		exit 1
		;;
esac


# TODO: investigate why umask from ~/.zprofile is ignored by newer ZSH versions.
umask 0077

# Put your fun stuff here.
# ------------------------
autoload -Uz zrecompile

# Dynamic load and compile all the module set-ups, and helper functions.
if [ -d "${ZSH_ENV_DIR}" ]; then
	for script in "${ZSH_ENV_DIR}"/*.zsh ; do
		[[ ! -f "${script}" ]] && continue
		[[ ! -r "${script}" ]] && continue
		. "${script}"
		zrecompile -p "${script}"
	done
	unset script
fi

# Load direnv helper functions
if command -v direnv >/dev/null 2>&1; then
	eval "$( direnv hook zsh )"
fi

# Compile everything in the configuration directory.
for script in "${ZDOTDIR}"/.z* ; do
	[[ "${script}" =~ \.(old|zwc)$ ]] && continue
	[[ -r "${script}" ]] && zrecompile -p "${script}"
done
unset script


autoload -Uz zmv
autoload -Uz zcalc
