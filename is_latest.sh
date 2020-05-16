#!/bin/bash

set -o errexit
set -o pipefail

source lib/zoom.sh

latest_version=$(fetch_latest_version)
latest_ebuild="net-im/zoom/zoom-$latest_version.ebuild"

# Test the latest ebuild exists
[[ -e "${latest_ebuild}" ]] && exit 0

# Latest ebuild does not exist, output the expected version
echo "$latest_version"
