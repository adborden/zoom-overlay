
build: zoom_x86_64.tar.xz

version.txt:
	curl -I https://zoom.us/client/latest/zoom_x86_64.tar.xz | sed -E -n -e '/^Location: / {s!Location: (https?://.*)!\1!;p}' > $@


zoom_x86_64.tar.xz:
	wget --timestamping https://zoom.us/client/latest/zoom_x86_64.tar.xz


.PHONY: build
