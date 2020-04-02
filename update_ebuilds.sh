#!/bin/bash
set -o errexit
set -o pipefail
set -x


function fetch_latest_version () {
	# HEAD the latest, and get the version from the Location header, removing trailing CRLF.
	curl --fail --silent -I https://zoom.us/client/latest/zoom_x86_64.tar.xz | \
		sed -E -n -e '/^Location: / {s!Location: https?://[A-z0-9]+\.cloudfront.net/prod/([0-9\.]+)/zoom_x86_64.tar.xz.*!\1!;p}' | \
		tr -d '[:space:]'
}

function most_recent_ebuild () {
	ls -1 net-im/zoom/zoom-*.ebuild | sort -n | head -1
}

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
