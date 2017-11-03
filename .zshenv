# .zshenv

# This configuration file will be called immediately after /etc/zshenv.
# You should only add things such as environment variables and stuff you want
# to make available to any type of shell, whether it's interactive or not.

# basedir defaults, in case they're not already set up.
# http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
if [[ -z "$XDG_DATA_HOME" ]]; then
	export XDG_DATA_HOME="$HOME/.local/share"
fi

if [[ -z "$XDG_CONFIG_HOME" ]]; then
	export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -z "$XDG_CACHE_HOME" ]]; then
	export XDG_CACHE_HOME="$HOME/.cache"
fi

if [[ -z "$XDG_DATA_DIRS" ]]; then
	export XDG_DATA_DIRS="/usr/local/share:/usr/share"
fi

if [[ -z "$XDG_CONFIG_DIRS" ]]; then
	export XDG_CONFIG_DIRS="/etc/xdg"
else
	export XDG_CONFIG_DIRS="/etc/xdg:$XDG_CONFIG_DIRS"
fi

# Ensure that ZSH's cache directory exists
if [[ ! -d "${XDG_CACHE_HOME}/zsh" ]]; then
	mkdir -p "${XDG_CACHE_HOME}/zsh"
fi

ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# This is the directory where all the custom ZSH functions are stored.
# By default, it is an empty string.
# If you want to use a different path, then override the default value with
# and absolute path name pointing to a zsh.d/ directory.
ZSHD_DIR=""

# Determine the location of the zsh.d/ directory
if [[ -z ${ZSHD_DIR} ]]; then
	local zshenv="$HOME/.zshenv"
	if [[ ! -L ${zshenv} ]]; then
		printf "${zshenv} is not a symbolic link!\n"
		printf "this file has not been installed by 'bestow'.\n"
		printf "sorry, I cannot continue. Please, ask upstream for feedbacks:\n"
		printf "-  https://github.com/Dr-Terrible/dotfiles-zsh\n"
		exit 1
	fi

	ZSHD_DIR="$( readlink ${zshenv} )"
	ZSHD_DIR="$( dirname ${ZSHD_DIR} )/zsh.d"
fi
