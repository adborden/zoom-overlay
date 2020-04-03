#!/bin/bash
set -o errexit
set -o pipefail
set -x

source lib/zoom.sh

latest_version=$(fetch_latest_version)
branch="ebuild-$latest_version"

git config user.name "CI bot"
git config user.email "bot@example.com"
git add .
git commit -m "New ebuild"

git push origin "HEAD:$branch"

pull_request_data=$(mktemp)

cat <<EOF > $pull_request_data
{
  "title": "Ebuild for ${latest_version}",
  "head": "${branch}",
  "base": "master",
  "body": "Hello!\nThere is a new version of Zoom available for download. Please review this ebuild so that it can be published to the overlay."
}
EOF

curl --silent --fail --user "$GITHUB_TOKEN" --data "@${pull_request_data}" https://api.github.com/repos/adborden/zoom-overlay/pulls > /dev/null 2>&1

rm -rf "$pull_request_data"

echo ok
