# Shared roster for the instructor scripts.
TEAM_COUNT="${WORKSHOP_TEAM_COUNT:-30}"
if ! [[ "$TEAM_COUNT" =~ ^([1-9]|[12][0-9]|30)$ ]]; then
  echo "WORKSHOP_TEAM_COUNT must be between 1 and 30." >&2
  exit 1
fi

TEAMS=()
for (( index = 1; index <= TEAM_COUNT; index++ )); do
  TEAMS+=("team$index")
done

TEAM_LABEL=workshop.localleon.github.io/team
CODER_TEMPLATE=Workshop-Kubernetes
CREDENTIAL_DIR="$SCRIPT_DIR/workshop-kubeconfigs"
