# If ~/.config/git/config does not exist, then we create the missing directory
# and we move over ~/.gitconfig
if [ ! -d "${XDG_CONFIG_HOME}/git" ]; then
	mkdir -p ${XDG_CONFIG_HOME}/git
fi
if [ -r "${HOME}/.gitconfig" ]; then
	if [ ! -e "${XDG_CONFIG_HOME}/git/config" ]; then
		cp "${HOME}/.gitconfig" "${HOME}/.gitconfig.delete"
		mv "${HOME}/.gitconfig" "${XDG_CONFIG_HOME}/git/config"
	fi
fi

# TODO: add ZSH auto-completion support

# @FUNCTION: git-fixconfig
# @DESCRIPTION:
#
# Fixes global settings for git.
function git-fixconfig() {
	if command -pv git >/dev/null 2>&1; then
		git config --global user.email  toffanin.mauro@gmail.com
		git config --global user.name   'Mauro Toffanin'
		git config --global color.ui    auto

		git config --global github.user Dr-Terrible

		# TODO: create a specific vimb profile for git.
		if command -v vimb >/dev/null 2>&1; then
			git config --global web.browser vimb
			git config --global browser.vimb.cmd vimb
		fi

		git config --global giggle.main-window-maximized       true
		git config --global giggle.main-window-geometry        580x292+0+0
		git config --global giggle.main-window-view            HistoryView
		git config --global giggle.file-view-vpane-position    398
		git config --global giggle.history-view-vpane-position 492

		git config --global push.default          simple
		git config --global core.quotepath        false
		git config --global core.whitespace       'trailing-space,space-before-tab,indent-with-non-tab,tabwidth=4'
		git config --global core.fsyncObjectFiles false
		git config --global core.preloadindex     true
		git config --global credential.helper     'cache --timeout=3600'
		git config --global commit.gpgsign        true
		git config --global diff.algorithm        minimal
		git config --global gc.auto               true

		git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
	fi
}