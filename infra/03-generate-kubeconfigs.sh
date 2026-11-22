#!/usr/bin/env bash
set -euo pipefail
umask 077

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/teams.sh"

: "${WORKSHOP_CONTEXT:?Set WORKSHOP_CONTEXT to the lab admin kubeconfig context}"
TOKEN_DURATION="${WORKSHOP_TOKEN_DURATION:-8h}"
admin() { kubectl --context "$WORKSHOP_CONTEXT" "$@"; }

# Copy only the server and TLS settings from the selected context.
cluster=$(admin config view --flatten --raw --minify -o json | jq -ce '
  .clusters[0].cluster
  | {server, "certificate-authority-data", "tls-server-name"}
  | with_entries(select(.value != null))
  | select(.server | startswith("https://"))
')
install -d -m 700 "$CREDENTIAL_DIR"
tmp=""
trap 'if [[ -n "$tmp" ]]; then rm -f -- "$tmp"; fi' EXIT

for team in "${TEAMS[@]}"; do
  namespace=$(admin get namespace "$team" --ignore-not-found -o json)
  if [[ -z "$namespace" ]]; then
    admin create namespace "$team" --dry-run=client -o json |
      jq --arg key "$TEAM_LABEL" --arg team "$team" '
        .metadata.labels += {($key): $team, "pod-security.kubernetes.io/enforce": "baseline"}
      ' |
      admin create -f -
  elif ! jq -e --arg key "$TEAM_LABEL" --arg team "$team" '.metadata.labels[$key] == $team' <<< "$namespace" >/dev/null; then
    echo "Namespace $team exists without the workshop label." >&2
    exit 1
  elif ! jq -e '.metadata.labels["pod-security.kubernetes.io/enforce"] | IN("baseline", "restricted")' <<< "$namespace" >/dev/null; then
    resource_version=$(jq -er '.metadata.resourceVersion' <<< "$namespace")
    admin label namespace "$team" pod-security.kubernetes.io/enforce=baseline \
      --overwrite --resource-version="$resource_version"
  fi

  admin -n "$team" create serviceaccount learner --dry-run=client -o yaml | admin apply -f -
  admin -n "$team" apply -f "$SCRIPT_DIR/templates/namespaced-default-role.yaml"
  admin -n "$team" create rolebinding workshop-learner --role=workshop-learner \
    --serviceaccount="$team:learner" --dry-run=client -o yaml | admin apply -f -

  tmp=$(mktemp "$CREDENTIAL_DIR/.kubeconfig.XXXXXX")
  admin -n "$team" create token learner --duration "$TOKEN_DURATION" |
    jq -Rn --arg team "$team" --argjson cluster "$cluster" '
      input as $token | {
        apiVersion: "v1", kind: "Config",
        clusters: [{name: "workshop", cluster: $cluster}],
        users: [{name: $team, user: {token: $token}}],
        contexts: [{name: $team, context: {cluster: "workshop", user: $team, namespace: $team}}],
        "current-context": $team
      }
    ' > "$tmp"
  mv -f -- "$tmp" "$CREDENTIAL_DIR/$team.kubeconfig"
  tmp=""
  printf 'Created %s.kubeconfig\n' "$team"
done
