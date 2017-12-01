# This helper function ensures that the vendoring tool specified with
# GOVENDORINGTOOL can be invoked freely from everywhere within the
# project root directory.
#
# A locking mechanism ensures that overlapping executions are avoided,
# making the function suitable for Continuous Integration software
# and multi-users environments.
#
# Legend of exit errors:
# -1: flock failed when executing the vendoring tool
#  1: GOVENDORINGTOOL is empty, or absent
#  2: GOVENDORINGTOOL is not supported by this script
#  3: GOPATH is empty, or absent
#  4: VANITY is empty, or absent
#  5: VANITY path is initialized
#  6: TMPDIR is empty, or absent
function vendor() {

	# Validate GOVENDORINGTOOL
	[[ -n ${GOVENDORINGTOOL} ]] || {
		print "Declaration of a vendoring tool is missing within .envrc, or GOVENDORINGTOOL is empty!"
		return 1
	}
	case ${GOVENDORINGTOOL} in
		dep|gvt|gops|gopm|glide|gb)
			#print "Using '${GOVENDORINGTOOL}' as vendoring tool"
			;;
		*)
			print "Vendoring tool '${GOVENDORINGTOOL}' is not supported by function vendor()."
			return 2
			;;
	esac

	# Validate GOPATH
	# A valid project root directory is required to properly ensure that the
	# function vendor() can be freely, and safely, invoked from everywhere
	# within the project itself.
	[[ -n ${GOPATH} ]] || {
		print "No valid GOPATH found! Check your .envrc file for missing declarations."
		return 3
	}

	# Validate VANITY
	[[ -n ${VANITY} ]] || {
		print "No valid VANITY found! Check your .envrc file for missing declarations."
		return 4
	}

	# Extract the absolute vanity path
	local vanity_path="$GOPATH/src/$VANITY"
	[[ -d ${vanity_path} ]] || {
		print "VANITY path '$vanity_path' has not been created."
		print "Check your .envrc file for missing declarations."
		return 5
	}

	if [ -z "${TMPDIR}" ]; then
		print "Environment variable \$TMPDIR is missing"
		return 6
	fi

	# Execute commands under lock
	(
		flock 9 || return -1

		# Change the current working directory to the absolute vanity path
		pushd "${vanity_path}" > /dev/null

			ionice -c 3 -t ${GOVENDORINGTOOL} ${@}

		popd > /dev/null

	) 9>${TMPDIR}/vendor.lock
}
