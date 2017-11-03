# Set up history
setopt SHARE_HISTORY          # share history between different zsh processes
setopt EXTENDED_HISTORY       # save a timestamp and duration for each history entry
setopt HIST_IGNORE_ALL_DUPS   # ignore duplicate entries when showing results
setopt HIST_FIND_NO_DUPS      # don't display eventual duplicates of a line that has already been found
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS     # remove extra spaces and tabs from each history entry
setopt HIST_VERIFY            # ask for confirmation every time you bang a command
setopt HIST_FCNTL_LOCK        # use fcntl on modern OS (avoid history corruption)
setopt HIST_REDUCE_BLANKS     # remove superfluous blanks from each command line being added to the history list
setopt INC_APPEND_HISTORY     # add entries to the history as they are typed, without waiting until the shell exits

export HISTSIZE=2000
export HISTFILE="${XDG_CACHE_HOME}/.history"
export SAVEHIST="${HISTSIZE}"