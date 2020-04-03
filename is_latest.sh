#!/bin/bash

set -o errexit
set -o pipefail

source lib/zoom.sh

# Test the latest ebuild exists
latest_ebuild="net-im/zoom/zoom-$(fetch_latest_version).ebuild"

if [[ -e "${latest_ebuild}" ]]; then
	echo ok
	exit 0
fi

echo "$latest_ebuild" does not exist and should be created. >&2
exit 1
