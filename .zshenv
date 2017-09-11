# .zshenv

# This configuration file will be called immediately after /etc/zshenv.
# You should only add things such as environment variables and stuff you want
# to make available to any type of shell, whether it's interactive or not.

# This is the directory where all the custom ZSH functions are stored.
# By default, it is an empty string.
# If you want to use a different path, then override the default value with
# and absolute path name pointing to a zsh.d/ directory.
ZSHD_DIR=""

# Determine the location of the zsh.d/ directory
if [[ -z ${ZSHD_DIR} ]]; then
	local zshenv="$HOME/.zshenv"
	if [[ ! -L ${zshenv} ]]; then
		log_status "${zshenv} is not a symbolic link!"
		log_status "this file has not been installed by 'bestow'."
		log_status "sorry, I cannot continue. Please, ask upstream for feedbacks:"
		log_status "-  https://github.com/Dr-Terrible/dotfiles-zsh"
		exit 1
	fi

	ZSHD_DIR="$( readlink ${zshenv} )"
	ZSHD_DIR="$( dirname ${ZSHD_DIR} )/zsh.d"
fi

# Set up direnv shell scripts
if command -V direnv >/dev/null 2>&1; then
	eval "$( direnv hook zsh )"
fi