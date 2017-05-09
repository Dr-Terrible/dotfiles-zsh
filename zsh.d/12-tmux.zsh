# TODO: add ZSH auto-completion support

# @FUNCTION: tmux-open
# @DESCRIPTION:
#
# Connects to a specific named session with tmux.
function tmux-open() {
	local session_name="${1:-empty}"

	# Validate the session name
	session_name=$( _validate_tmux_session_name "${session_name}" tmux-open )

	tmux attach -t "${session_name}"
}

# @FUNCTION: tmux-kill
# @DESCRIPTION:
#
# Kills a specific named session with tmux.
function tmux-kill() {
	local session_name="${1:-empty}"

	# Validate the session name
	session_name=$( _validate_tmux_session_name "${session_name}" tmux-kill )

	tmux kill-session -t "${session_name}"
}

# @FUNCTION: tmux-killall
# @DESCRIPTION:
#
# Kills all the active and running named sessions.
function tmux-killall() {
	local sessions=( $( tmux list-sessions -F "#{session_name}" ) )

	for session in ${sessions[@]}; do
		tmux kill-session -t ${session}
	done
}

# @FUNCTION: _validate_tmux_session_name
# @INTERNAL
# @DESCRIPTION:
#
# This helper function strips any leading-trailing white space from a session
# name, and converts any dots (.) into hyphens characters.
function _validate_tmux_session_name() {
	local session_name="${1:-empty}"
	local function_name="${2}"

	# Strip any leading and trailing white spaces
	session_name=$( echo ${session_name} )

	# Exit if the session name is empty
	if [[ "empty" == ${session_name} ]]; then
		log_status "You must supply a valid session name when invoking ${function_name}!"
		exit 1
	fi

	# Convert any dots (.) into hyphens characters
	echo "${session_name//./-}"
}