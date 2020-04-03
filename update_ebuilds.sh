#!/bin/bash
set -o errexit
set -o pipefail

source lib/zoom.sh

function main () {
	local ebuild latest_version

	latest_version=$(fetch_latest_version)
	ebuild="net-im/zoom/zoom-${latest_version}.ebuild"

	if [[ -e "$ebuild" ]]; then
		# Ebuild is up to date, we're done.
		echo "$ebuild" is up to date.
		return
	fi

	# Copy the ebuild from the last version (and hope it still works)
	cp "$(most_recent_ebuild)" "$ebuild"
	echo added "$ebuild"
}

main
