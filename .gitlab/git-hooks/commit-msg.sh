#!/usr/bin/env bash
# commit-msg hook: rejects a commit whose subject does not follow this repo's
# convention, `#<issue-id> :<gitmoji>: <description>` — see "Commit convention"
# in the README. Only the subject is matched, so a commit body stays free-form.
#
# pre-commit passes the path to the commit message file as the only argument.
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"
# shellcheck source=.gitlab/git-hooks/colors.sh
source .gitlab/git-hooks/colors.sh

readonly project_url="https://gitlab.com/corthx/portfolio"
readonly convention_url="${project_url}#commit-convention"
readonly gitmoji_url="https://gitmoji.dev"

readonly gitmojis="sparkles|bug|art|recycle|test_tube|pencil|lipstick|wrench|truck|arrow_up|arrow_down|lock|label|zap|rewind|tada|beers|twisted_rightwards_arrows|construction|fire|heavy_minus_sign|heavy_plus_sign|green_heart|white_check_mark"

# Progressively stricter patterns, so a rejection can name the part that is wrong
# instead of only that the whole subject failed.
readonly re_issue_key='^#[0-9]+'
readonly re_gitmoji="${re_issue_key} :(${gitmojis}):"
readonly re_description="${re_gitmoji} ."
readonly re_subject="${re_gitmoji} .{10,}$"

subject="$(head -n 1 "$1")"
printf '%sDetected commit subject: %s%s\n' "$info" "$subject" "$none"

if [[ "$subject" =~ $re_subject ]]; then
  printf '%sCommit is valid%s\n' "$success" "$none"
  exit 0
fi

printf '%sYour commit does not match the convention, please commit again with a valid message%s\n' "$error" "$none"
printf '%sYou can find the commit convention here: %s%s\n' "$bold" "$convention_url" "$none"
printf '%sInvalid commit, nothing committed%s\n' "$error" "$none"

if [[ ! "$subject" =~ $re_issue_key ]]; then
  printf '%sYour commit does not contain a valid GitLab issue key%s\n' "$error" "$none"
elif [[ ! "$subject" =~ $re_gitmoji ]]; then
  printf '%sYour commit does not contain a valid Gitmoji, you can find the Gitmoji list here: %s%s\n' "$error" "$gitmoji_url" "$none"
elif [[ ! "$subject" =~ $re_description ]]; then
  printf '%sYour commit contains no description%s\n' "$error" "$none"
else
  printf '%sYour commit description is too short, it should be at least 10 characters long%s\n' "$error" "$none"
fi

printf "A valid commit looks like the following: '#5 :sparkles: Add a button to delete a user'\n"
exit 1
