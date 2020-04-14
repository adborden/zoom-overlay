#!/bin/bash
set -o errexit
set -o pipefail

source lib/zoom.sh

latest_version=$(fetch_latest_version)
branch="ebuild-$latest_version"

# Check if there are untacked files in this git repository. Note: this will
# only return 0 for untracked files. Changes do existing files are not
# conisdered.
function has_untracked_files () {
	[[ "$(git ls-files --others --exclude-standard | wc -l)" -gt 0 ]]
}

function has_remote_branch () {
	local branch
	branch=${1}

	git ls-remote --quiet --heads | grep --quiet --word-regexp "refs/heads/${branch}"
}

function commit_and_push () {
	git config user.name "CI bot"
	git config user.email "bot@example.com"
	git add net-im/zoom
	git commit -m "net-im/zoom-${latest_version}"
	git push origin "HEAD:$branch"
}

function create_pr () {
	curl -v --fail --user "$GITHUB_USER:$GITHUB_TOKEN" -H 'Content-Type: application/json' --data @- https://api.github.com/repos/adborden/zoom-overlay/pulls <<EOF | jq -r '.url' || ( echo error: failed to create pull request for changes. >&2; exit 1 )
{
  "title": "ebuild for net-im/zoom-${latest_version}",
  "head": "${branch}",
  "base": "master",
  "body": "Hello!\n\nThere is a new version of Zoom available for download. Please review this ebuild so that it can be published to the overlay."
}
EOF
}

function main () {
	local pr_url

	# Make sure there are changes to commit
	if ! has_untracked_files; then
		echo no untracked files to commit.
		echo ok
		return 1
	fi

	# Make sure we haven't pushed the branch before
	if has_remote_branch $branch; then
		echo remote branch already exists.
		echo ok
		return 1
	fi

	# Commit changes and push
	commit_and_push

	# We don't check for an existing pull request, but we already checked the
	# remote branch doesn't exist, so the PR shouldn't exist either.
	pr_url=$(create_pr)
	echo created pull request "$pr_url"
}


main
