#!/bin/bash

set -o errexit
set -o pipefail

source lib/zoom.sh

latest_version=$(fetch_latest_version)
latest_ebuild="net-im/zoom/zoom-$latest_version.ebuild"

# Test the latest ebuild exists
if [[ -e "${latest_ebuild}" ]]; then
	echo ok
	exit 0
fi

echo "$latest_version"
exit 1
