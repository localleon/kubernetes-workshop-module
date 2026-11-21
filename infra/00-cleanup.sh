#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/teams.sh"

: "${WORKSHOP_CONTEXT:?Set WORKSHOP_CONTEXT to the lab admin kubeconfig context}"
: "${CODER_URL:?Set CODER_URL to the workshop Coder server}"
if [[ "${1:-}" != "--confirm" ]]; then
  printf 'This deletes workshop accounts and namespaces on %s and %s.\n' "$CODER_URL" "$WORKSHOP_CONTEXT" >&2
  printf 'Run %s --confirm after checking both targets.\n' "$0" >&2
  exit 1
fi

users=$(coder users list --output json)
for team in "${TEAMS[@]}"; do
  user_id=$(jq -r --arg team "$team" --arg email "$team@example.com" \
    '.[] | select(.username == $team and .email == $email) | .id' <<< "$users")
  if [[ -n "$user_id" ]]; then
    workspaces=$(coder list --search "owner:$team" --output json)
    names=$(jq -r --arg team "$team" --arg template "$CODER_TEMPLATE" '
      .[] | select(.owner_name == $team and .template_name == $template) | .name
    ' <<< "$workspaces")
    while IFS= read -r workspace; do
      if [[ -n "$workspace" ]]; then
        coder delete "$team/$workspace" --yes
      fi
    done <<< "$names"
    coder users delete "$user_id"
  fi
  kubectl --context "$WORKSHOP_CONTEXT" delete namespace \
    --selector "$TEAM_LABEL=$team" --ignore-not-found
  rm -f -- "$CREDENTIAL_DIR/$team.kubeconfig"
done
