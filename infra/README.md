# Workshop infrastructure

Use AKS **1.36.x** with an enforced NetworkPolicy data plane, Azure Workload Identity, and the `managed-csi` storage class. Rancher 2.15.3 supports AKS through 1.36. The core exercises also target upstream Kubernetes 1.37.

## Bootstrap

1. Set `WORKSHOP_CONTEXT` to the lab admin kubeconfig context. Check the ExternalDNS identity, `external-dns-azure` Secret in the `external-dns` namespace, DNS zone, ingress hostnames, and ACME email in the manifests.
2. Run `infra/01-bootstrap.sh` with Flux CLI 2.10.1 and authorized GitHub access. The script bootstraps Flux against `main`.
3. Wait for `flux --context "$WORKSHOP_CONTEXT" get kustomizations` to show `apps` and `workshop` ready.

For an existing lab, snapshot the Coder database and Rancher before upgrading. Follow each vendor's supported upgrade path, including Flux API migration, before reconciling the new pins. Remove the old workshop `global-view` ClusterRoleBindings and long-lived learner token Secrets to revoke legacy access.

## Learners

1. Set `CODER_URL` to the workshop Coder server and log in with `coder login "$CODER_URL"`.
2. Run `infra/02-coder-setup.sh` and `infra/03-generate-kubeconfigs.sh`.
3. Hand each team its own Coder credentials and kubeconfig from `infra/workshop-kubeconfigs/`. The kubeconfig requests an eight-hour token by default.

The scripts default to `team1` through `team30`. Use the same `WORKSHOP_TEAM_COUNT` for each script to run a smaller workshop. Rerun kubeconfig generation to renew tokens.

At the end, run `infra/00-cleanup.sh --confirm` after checking the target context and server. It deletes workshop workspaces, team accounts, and labeled team namespaces. Remove the local Coder credentials file after distributing the credentials.

## Container build workspaces

The `Workshop-Kubernetes` image ships neither Docker nor Podman. The template mounts the learner's home volume and provides no container engine socket or sidecar. Learners can build locally with [Podman](https://podman.io/docs/installation).

For browser-only learners, offer a separate [Linux VM workspace](https://registry.coder.com/templates/coder/azure-linux) per team with rootless Podman in its image or startup script. On Ubuntu, install `podman` and `uidmap` and give the workspace user subordinate UID and GID ranges. In a test workspace, run `podman info` and build and run the Python exercise as the workspace user before class.

To build inside the existing pod-based template, pilot [Coder’s rootless Podman setup](https://coder.com/docs/admin/templates/extending-templates/docker-in-workspaces/#rootless-podman) on the lab node pool. It requires a FUSE device and a compatible security profile.
