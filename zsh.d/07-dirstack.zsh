## DirStack

#TODO: simplify, tweak, and remove everything that is redundant

DIRSTACKSIZE=20
DIRSTACK="${XDG_CACHE_HOME}/zsh"
DIRSTACKFILE="${DIRSTACK}/dirstack"

[[ -d ${DIRSTACK} ]] && mkdir -p "${DIRSTACK}"

if [[ -f ${DIRSTACKFILE} ]] && [[ ${#dirstack} -eq 0 ]]; then
	dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
	[[ -d ${dirstack[1]} ]] && cd ${dirstack[1]}
fi

chpwd() {
	print -l ${PWD} ${(u)dirstack} >${DIRSTACKFILE}
}

setopt AUTO_PUSHD        # push the old directory onto the directory stack
setopt PUSHD_SILENT      # do not print the directory stack after pushd or popd
setopt PUSHD_TO_HOME     # have pushd with no arguments act like `pushd $HOME'
setopt PUSHD_IGNORE_DUPS # remove duplicate entries
setopt PUSHD_MINUS       # This reverts the +/- operators.
