# Initialize the prompt system
autoload -Uz promptinit
promptinit

# Load and enable Powerline if available, otherwise fallback to a regular prompt
if [[ -r /usr/share/zsh/site-contrib/powerline.zsh ]]; then
	. /usr/share/zsh/site-contrib/powerline.zsh
	#VIRTUAL_ENV_DISABLE_PROMPT=true
else
	prompt gentoo
fi
