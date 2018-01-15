# .zlogout
# This configuration file will be called immediately after /etc/zlogout.
# It's executed by zsh(1) when login shell exits.

# Clean up old ZSH pre-compiled files
rm -f "${ZSH_ENV_DIR}"/\*zwc.old
rm -f "${ZDOTDIR}"/.\*zwc.old

# Clean up old Direnv hashes
if command -v direnv >/dev/null 2>&1; then
	eval "$( direnv prune )"
fi

# Clear the screen to increas privacy, when leaving the console
if [ "$SHLVL" = 1 ]; then
    clear
fi

# Invalidate cached sudo credentials
sudo -k
