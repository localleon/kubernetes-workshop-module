# Dive-In Kubernetes: Basic Concepts

## Beschreibungstext

In diesem Dive-In Workshop bekommt ihr einen Überblick über das Basiskonzept von Kubernetes, Grundlagen von Containern und vielen anderen Ressourcen vermittlet. Darüber hinaus sprechen wir über aktuelles Tooling und stellen einige kurz vor.

## Workshop requirements

The workshop toolchain image is available under `ghcr.io/localleon/kubernetes-workshop-module/kubernetes-toolcontainer:latest` and is built with Github Actions from this repository.

To participate in our workshops you will require the following items on your notebook or in the toolchain container:

* Linux, MacOS or Windows idealy with an administrator access
* kubernetes client software kubectl
  * [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* helm client software version 3.x
  * [Install helm](https://helm.sh/docs/intro/install)
* Optionally: kubectx context management tool
  * [Install kubectx](https://github.com/ahmetb/kubectx/)
* Optionally: Docker desktop software
  * [Install Docker desktop Windows](https://docs.docker.com/docker-for-windows/install/)
  * [Install Docker desktop MacOS](https://docs.docker.com/docker-for-mac/install/)

## Create your workspace (if you don't have local tooling)

Navigate to the provided URL of "coder" in your browser. 

1. Login with your provided credentials 
2. Use the button "Create Workspace" and select the Template "Workshop-Kubernetes". This will provide you with all the required tools for the workshop 
3. Wait for your workspace to enter the running state and that "code-server" has been installed 
4. Click the "code-server" button in your workspace to open up your main terminal/text-editor session for this workshop. 
5. In the "Code-Server" window, use VS-Code as normally and install the "Kubernetes" Extension from the Marketplace via the sidebar. 
6. Open a terminal by clicking at "Hamburger Menu at Sidebar" > "Terminal" > "New Terminal"  
7. Copy your provided kubeconfig to `~/.kube/config` and use 'export KUBECONFIG=~/.kube/config' to activate it for the current context 

Now you are ready to start exploring the cluster! Please also clone the workshop-repository with 'git clone https://github.com/localleon/kubernetes-workshop-module.git' into your workspace so you have all files on hand! 

We are ready to start with the workshop! 

## Extra

You can stop reading here. These are informations for after the workshop! 

- `k9s` -> https://github.com/derailed/k9s
- Lens -> https://k8slens.dev/
- Web basierter Generator für K8S YMLs -> https://k8syaml.com/

### Docker (Ersatz/lizenztechnisches)

- bei Lizenzbedenken bzgl. Docker Desktop auf Windows -> https://dev.to/_nicolas_louis_/how-to-run-docker-on-windows-without-docker-desktop-hik
- Podman als Docker Ersatz - https://podman.io/

### k8s testen

- KIND (Kubernetes in Docker) -> https://kind.sigs.k8s.io/ (empfohlen)
- kubeadm (minimum viable Kubernetes cluster) -> https://kubernetes.io/docs/reference/setup-tools/kubeadm/
- k3s (Lightweight Kubernetes) -> https://k3s.io/
- k3d (k3d is a lightweight wrapper to run k3s) -> https://k3d.io/

### Additional tooling and resources

* https://github.com/aylei/kubectl-debug
* https://github.com/kubernetes-sigs/krew
* https://github.com/corneliusweig/rakkess
* https://github.com/derailed/popeye
* https://github.com/kubernetes-sigs/krew-index/blob/master/plugins/view-secret.yaml
* https://github.com/kubernetes-sigs/krew-index/blob/master/plugins/get-all.yaml
* https://github.com/kubernetes-sigs/krew-index/blob/master/plugins/resource-capacity.yaml
* https://github.com/kubernetes-sigs/krew-index/blob/master/plugins/view-utilization.yaml
* https://github.com/instrumenta/kubeval
* https://github.com/hadolint/hadolint
* https://www.telepresence.io/
* https://github.com/weaveworks/flux
* https://tilt.dev/
* https://argoproj.github.io/argo-cd/
* https://kubernetes.github.io/ingress-nginx/
* https://cert-manager.readthedocs.io/
* https://github.com/presslabs/mysql-operator
* https://github.com/coreos/prometheus-operator
* https://prometheus.io/
* https://grafana.com
* https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.16/
* https://operatorhub.io/
* https://keel.sh/
* https://helm.sh/
* https://ahmet.im/blog/mastering-kubeconfig/
* https://github.com/IBM/kui
* https://github.com/bitnami-labs/sealed-secrets
* https://github.com/eldadru/ksniff
* https://kubernetes.academy/
* https://github.com/jonmosco/kube-ps1
* https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler
* https://github.com/herbrandson/k8dash
* https://github.com/kubernetes/dashboard
* https://gitlab.com/bashofmann/angular-test-app-finished
* https://github.com/kelseyhightower/kubernetes-the-hard-way
* https://k8s.af/
* https://github.com/derailed/k9s
* https://github.com/ramitsurana/awesome-kubernetes
* https://github.com/int128/kubelogin
* https://github.com/wagoodman/dive
