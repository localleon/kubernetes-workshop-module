#!/usr/bin/env bash
set -euo pipefail
umask 077

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/teams.sh"

: "${CODER_URL:?Set CODER_URL to the workshop Coder server}"
coder templates push --directory "$SCRIPT_DIR/templates/coder-template" "$CODER_TEMPLATE" --yes

install -d -m 700 "$CREDENTIAL_DIR"
credentials=$(mktemp "$CREDENTIAL_DIR/coder-credentials.XXXXXX.tsv")
printf 'username\tpassword\n' > "$credentials"
printf 'New account credentials will be written to %s\n' "$credentials"

users=$(coder users list --output json)
for team in "${TEAMS[@]}"; do
  email="$team@example.com"
  if jq -e --arg team "$team" --arg email "$email" \
    '.[] | select(.username == $team and .email == $email)' <<< "$users" >/dev/null; then
    continue
  fi
  password=$(openssl rand -hex 16)
  coder users create --email "$email" --username "$team" --password "$password"
  printf '%s\t%s\n' "$email" "$password" >> "$credentials"
done
