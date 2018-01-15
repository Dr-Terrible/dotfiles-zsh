# .zshenv

# This configuration file will be called immediately after /etc/zshenv.
# You should only add things such as environment variables and stuff you want
# to make available to any type of shell, whether it's interactive or not.

# basedir defaults, in case they are not already set up.
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

# This is the directory where all the custom ZSH functions that tinker with the
# environment are stored. By default, it is an empty string.
#
# NOTE: if you want to use a different path, then override the default value
# with an absolute path name pointing to a zsh.env.d/ directory.
ZSH_ENV_DIR=""

# Determine the location of the zsh.env.d/ directory in a portable way.
if [[ -z ${ZSH_ENV_DIR} ]]; then
	# Determine the current working directory.
	local cwd="$( pwd -P )"
	[[ -z ${cwd} ]] && continue

	# Resolve symlinks, if present.
	local zshenv="${cwd}/.zshenv"
	zshenv="$( readlink -f ${zshenv} )"

	# Check if zsh.env.d/ directory exists.
	local zshd="$( dirname ${zshenv} )/zsh.env.d"
	if [[ -d "${zshd}" ]]; then
		# We got our directory. Let's roll!
		ZSH_ENV_DIR="${zshd}"
	fi
fi

# This is the directory where all the custom ZSH plug-ins are stored.
# By default, it is an empty string.
#
# NOTE: if you want to use a different path, then override the default value
# with an absolute path name pointing to a zsh.plugins.d/ directory.
ZSH_PLUGINS_DIR=""
