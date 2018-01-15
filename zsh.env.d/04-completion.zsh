# Enable tab-completion module

local cache_file="${XDG_CACHE_HOME}/zsh/.zcomp-$HOST"

autoload -Uz compinit
compinit -d "${cache_file}"
zrecompile -p -M "${cache_file}"

# Enable the auto-correction of the commands typed,
# and make zsh ask you for confirmation every time it suggests a correction
setopt CORRECT
#setopt correctall

# Use a cache
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${cache_file}"

# ZStyles
zstyle ":completion:*" auto-description "specify: %U%d%u"
zstyle ":completion:*" format "%BCompleting: %U%d%u%b"
zstyle ":completion:*:messages" format "%BCompleting: %U%d%u%b"
zstyle ':completion:*:warnings' format "%BNo matches for: %U%d%u%b"
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ":completion:*" group-name ""
zstyle ":completion:*" menu select=2
zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*" list-colors ""
zstyle ":completion:*" list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ":completion:*" matcher-list "" "m:{a-z}={A-Z}" "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=* l:|=*"
zstyle ":completion:*" menu select=long
zstyle ":completion:*" select-prompt %SScrolling active: current selection at %p%s
zstyle ":completion:*" verbose true
zstyle ':completion:*' rehash true

# remove the trailing slash when using a directory as an argument
zstyle ':completion:*' squeeze-slashes true

# Completers
zstyle ":completion:*" completer _expand _complete _correct _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Prevent CVS files/directories from being completed:

zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

# Filter completion functions for commands you don't have:
zstyle ':completion:*:functions' ignored-patterns '_*'

# cd - command
zstyle ':completion:*:cd:*' ignore-parents parent pwd # filter parents and current directories from autocompletion

# kill - command
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ":completion:*:*:kill:*:processes" list-colors "=(#b) #([0-9]#)*=0=01;31"
zstyle ":completion:*:kill:*" command "ps -u $USER -o pid,%cpu,tty,cputime,cmd"
