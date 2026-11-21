# Workshop infrastructure

Use AKS **1.36.x** with an enforced NetworkPolicy data plane, Azure Workload Identity, and the `managed-csi` storage class. Rancher 2.15.3 supports AKS through 1.36. The core exercises also target upstream Kubernetes 1.37.

## Bootstrap

1. Set `WORKSHOP_CONTEXT` to the lab admin kubeconfig context. Check the ExternalDNS identity, `external-dns-azure` Secret in the `external-dns` namespace, DNS zone, ingress hostnames, and ACME email in the manifests.
2. Run `infra/01-bootstrap.sh` with Flux CLI 2.10.1 and authorized GitHub access. The script bootstraps Flux against `main`.
3. Wait for `flux --context "$WORKSHOP_CONTEXT" get kustomizations` to show `apps` and `workshop` ready.

For an existing lab, snapshot the Coder database and Rancher before upgrading. Follow each vendor's supported upgrade path, including Flux API migration, before reconciling the new pins. Remove the old workshop `global-view` ClusterRoleBindings and long-lived learner token Secrets to revoke legacy access.

## Prepare teams before the workshop

Workshop leaders create the Coder accounts, namespaces, and kubeconfigs. Run the following from the repository root shortly before class.

1. Set `WORKSHOP_CONTEXT` to the lab admin context and `CODER_URL` to the lab Coder URL. Set `WORKSHOP_TEAM_COUNT` if you need fewer than 30 teams. Keep the same count for setup and cleanup.
2. Log in with `coder login "$CODER_URL"`, then run `infra/02-coder-setup.sh` and `infra/03-generate-kubeconfigs.sh`. The scripts create matching Coder accounts and Kubernetes namespaces for `team1`, `team2`, and so on.
3. Run `kubectl --kubeconfig infra/workshop-kubeconfigs/team1.kubeconfig get pods` to check access as a learner.
4. Give each team the Coder URL, its login from `infra/workshop-kubeconfigs/coder-credentials.*.tsv`, and its own `teamN.kubeconfig` from the same directory. The file already selects their namespace.

The kubeconfig requests an eight-hour token by default. Rerun kubeconfig generation and distribute a fresh file if a team needs a replacement.

At the end, run `infra/00-cleanup.sh --confirm` after checking the target context and server. It deletes workshop workspaces, team accounts, and labeled team namespaces. Remove the local Coder credentials file after distributing the credentials.

## Container builds in Coder

Use **Enable Podman** when creating or updating a lab workspace. This makes the workspace pod privileged. Enable it only on the lab cluster, in a namespace where admission allows privileged pods. Workspaces run Podman with `sudo` and store images for the lifetime of the workspace pod.

After the new tool image is published, push the updated Coder template. In a Podman-enabled workspace, run `sudo podman info` and try the [Python build and run exercise](../container-modules/python/README.md).
