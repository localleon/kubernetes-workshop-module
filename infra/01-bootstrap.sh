#!/usr/bin/env bash
set -euo pipefail

: "${WORKSHOP_CONTEXT:?Set WORKSHOP_CONTEXT to the lab admin kubeconfig context}"
flux bootstrap github \
  --context="$WORKSHOP_CONTEXT" \
  --version=v2.10.1 \
  --token-auth \
  --owner=localleon \
  --repository=kubernetes-workshop-module \
  --branch=main \
  --path=infra/fluxcd \
  --personal
