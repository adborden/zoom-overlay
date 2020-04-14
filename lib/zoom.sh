# Fetch the latest version of Zoom binary
function fetch_latest_version () {
	# HEAD the latest, and get the version from the Location header, removing trailing CRLF.
	curl --fail --silent -I https://zoom.us/client/latest/zoom_x86_64.tar.xz | \
		sed -E -n -e '/^location: /I {s!location: https?://[A-z0-9]+\.cloudfront.net/prod/([0-9\.]+)/zoom_x86_64.tar.xz.*!\1!I;p}' | \
		tr -d '[:space:]'
}

# Find the most recent ebuild
function most_recent_ebuild () {
	ls -1 net-im/zoom/zoom-*.ebuild | sort -r | head -1
}
