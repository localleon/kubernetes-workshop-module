# Dive-In Kubernetes

Lerne Container zu bauen, Anwendungen mit Kubernetes zu betreiben und Änderungen mit GitOps auszuliefern.

## Get started

- **Coder** — Open the workshop URL, create a workspace from `Workshop-Kubernetes`, then open its code-server terminal.
- **Local** — Install [kubectl](https://kubernetes.io/docs/tasks/tools/). For container builds, use Docker or Podman and a registry the lab can pull from.

In either terminal, create `~/.kube` and save the supplied kubeconfig as `~/.kube/workshop.yaml`. Then clone the workshop.

```sh
chmod 600 ~/.kube/workshop.yaml
export KUBECONFIG="$HOME/.kube/workshop.yaml"
git clone https://github.com/localleon/kubernetes-workshop-module.git
cd kubernetes-workshop-module
```

Your context selects your team's namespace.

## Workshop

1. [Build containers](container-modules) with Java, NGINX, Rust, and Python.
2. [Connect to Kubernetes](kubernetes-modules/00-intro) and work through chapters 01–07.
3. Continue with [Ingress and TLS](kubernetes-modules/08-deployment-with-ingress-and-tls), [Prometheus](kubernetes-modules/09-prometheus), [Rancher](kubernetes-modules/10-rancher), [Fleet](kubernetes-modules/11-gitops-fleet), [NetworkPolicy](kubernetes-modules/12-network-policies), and [Kyverno](kubernetes-modules/13-kyverno-policies).
4. Try [Argo CD](kubernetes-modules/14-gitops-argocd) and [cloud-native HA](kubernetes-modules/15-cloud-native-ha).

Core examples target Kubernetes 1.37.2. The full instructor lab targets AKS 1.36.x for Rancher compatibility. See the [instructor setup](infra) and [tooling list](k8s-tooling-list.md).
