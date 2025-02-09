# Create your workspace

Navigate to the provided URL of "coder" in your browser. 

1. Login with your provided credentials 
2. Use the button "Create Workspace" and select the Template "Workshop-Kubernetes". This will provide you with all the required tools for the workshop 
3. Wait for your workspace to enter the running state and that "code-server" has been installed 
4. Click the "code-server" button in your workspace to open up your main terminal/text-editor session for this workshop. 
5. In the "Code-Server" window, use VS-Code as normally and install the "Kubernetes" Extension from the Marketplace via the sidebar. 
6. Open a terminal by clicking at "Hamburger Menu at Sidebar" > "Terminal" > "New Terminal"  
7. Copy your provided kubeconfig to `~/.kube/config` and use 'export KUBECONFIG=~/.kube/config' to activate it for the current context 

Now you are ready to start exploring the cluster! Please also clone the workshop-repository with 'git clone https://github.com/localleon/kubernetes-workshop-module.git' into your workspace so you have all files on hand! 

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
