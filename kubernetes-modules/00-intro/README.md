# Load Kubeconfig for kubectl 

To connect with the cluster you need to load your corresponding kubeconfig. Just drop your kubeconfig-file into your home folder and set an absolute path via the `KUBECONFIG` environment variable to configure your credentials.

```bash
export KUBECONFIG=/home/coder/azurek8s-lab.yaml
```

After that you should be able to connect to the cluster and execute commands like `kubectl get nodes`

# Namespaces

* Check versions of local installation and remote server
  
```shell
kubectl version
```

* Verify kubectl uses your kubeconfig file by default

```shell
kubectl config view
```

* Try to connect

```shell
kubectl get nodes
```

* List Namespaces

```shell
kubectl get namespaces
```

* Set default namespace to context

```shell
kubectl config set-context --current --namespace=<YOURNAME>
```

* See change in kubeconfig

```shell
cat ~/.kube/config
```

* Verify that [helm is installed](https://helm.sh/docs/intro/install/) (should be 3.x.x)

```shell
helm version
```
