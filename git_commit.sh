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

pr_url=$(curl -v --fail --user "$GITHUB_USER:$GITHUB_TOKEN" -H 'Content-Type: application/json' --data @- https://api.github.com/repos/adborden/zoom-overlay/pulls <<EOF | jq '.url'
{
  "title": "Ebuild for ${latest_version}",
  "head": "${branch}",
  "base": "master",
  "body": "Hello!\nThere is a new version of Zoom available for download. Please review this ebuild so that it can be published to the overlay."
}
EOF
) || ( echo failed to create pull request for changes. >&2; exit 1 )

echo created pull request "$pr_url"
