
build: zoom_x86_64.tar.xz

version.txt:
	curl --fail --silent -I https://zoom.us/client/latest/zoom_x86_64.tar.xz | \
		sed -E -n -e '/^Location: / {s!Location: https?://[A-z0-9]+\.cloudfront.net/prod/([0-9\.]+)/zoom_x86_64.tar.xz.*!\1!;p}' | \
		tr -d '[:space:]' > $@


zoom_x86_64.tar.xz:
	wget --timestamping https://zoom.us/client/latest/zoom_x86_64.tar.xz


.PHONY: build
