# Dive-In Kubernetes

Lerne Container zu bauen, Anwendungen mit Kubernetes zu betreiben und Änderungen mit GitOps auszuliefern.

## Get started

- **Coder** — Sign in with the URL and team credentials from your workshop leader. Create a workspace from `Workshop-Kubernetes` and open its code-server terminal. Select **Enable Podman** for the container exercises.
- **Local** — Install [Podman](https://podman.io/docs/installation) for the container exercises and [kubectl](https://kubernetes.io/docs/tasks/tools/) for the Kubernetes exercises.

Clone the workshop in your terminal.

```sh
git clone https://github.com/localleon/kubernetes-workshop-module.git
cd kubernetes-workshop-module
```

Your workshop leader provides a team kubeconfig for the Kubernetes exercises. See the [leader setup](infra/README.md#prepare-teams-before-the-workshop).

## Workshop

1. [Build containers](container-modules) with Java, NGINX, Rust, and Python.
2. [Connect to Kubernetes](kubernetes-modules/00-intro) and work through chapters 01–07.
3. Continue with [Ingress and TLS](kubernetes-modules/08-deployment-with-ingress-and-tls), [Prometheus](kubernetes-modules/09-prometheus), [Rancher](kubernetes-modules/10-rancher), [Fleet](kubernetes-modules/11-gitops-fleet), [NetworkPolicy](kubernetes-modules/12-network-policies), and [Kyverno](kubernetes-modules/13-kyverno-policies).
4. Try [Argo CD](kubernetes-modules/14-gitops-argocd) and [cloud-native HA](kubernetes-modules/15-cloud-native-ha).

Core examples target Kubernetes 1.37.2. The full instructor lab targets AKS 1.36.x for Rancher compatibility. See the [instructor setup](infra) and [tooling list](k8s-tooling-list.md).
