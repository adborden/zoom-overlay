#!/bin/bash
set -o errexit
set -o pipefail


function fetch_latest_version () {
	# HEAD the latest, and get the version from the Location header, removing trailing CRLF.
	curl --fail --silent -I https://zoom.us/client/latest/zoom_x86_64.tar.xz | \
		sed -E -n -e '/^Location: / {s!Location: https?://[A-z0-9]+\.cloudfront.net/prod/([0-9\.]+)/zoom_x86_64.tar.xz.*!\1!;p}' | \
		tr -d '[:space:]'
}

function main () {
	echo "net-im/zoom/zoom-$(fetch_latest_version).ebuild"
}

main
