#!/usr/bin/env bash
# pre-push hook: rejects a push from a branch whose name does not follow this
# repo's convention, `<issue-id>-<summary>` — see "Branch naming convention" in
# the README.
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"
# shellcheck source=.gitlab/git-hooks/colors.sh
source .gitlab/git-hooks/colors.sh

readonly project_url="https://gitlab.com/corthx/portfolio"
readonly convention_url="${project_url}#branch-naming-convention"

# Progressively stricter patterns, so a rejection can name the part that is wrong.
readonly re_issue_key='^[0-9]+'
readonly re_summary="${re_issue_key}-.+$"
readonly re_branch="${re_issue_key}-[a-zA-Z0-9-]{2,}$"

# A detached HEAD has no branch name to check.
branch="$(git symbolic-ref --quiet --short HEAD)" || exit 0
printf '%sDetected branch name is: %s%s\n' "$info" "$branch" "$none"

if [[ "$branch" =~ $re_branch ]]; then
  printf '%sBranch name is valid%s\n' "$success" "$none"
  exit 0
fi

printf "%sYour branch name does not match the convention, please update it using 'git branch -m <new_name>'%s\n" "$error" "$none"
printf '%sYou can find the branch naming convention here: %s%s\n' "$bold" "$convention_url" "$none"
printf '%sInvalid branch name, nothing pushed%s\n' "$error" "$none"

if [[ ! "$branch" =~ $re_issue_key ]]; then
  printf '%sYour branch name does not contain a valid GitLab issue key%s\n' "$error" "$none"
elif [[ ! "$branch" =~ $re_summary ]]; then
  printf '%sYour branch name contains no summary%s\n' "$error" "$none"
else
  printf '%sYour branch name summary is too short, it should be at least 2 characters long%s\n' "$error" "$none"
fi

printf "A valid branch name looks like the following: '5-Add-delete-user-button'\n"
exit 1
