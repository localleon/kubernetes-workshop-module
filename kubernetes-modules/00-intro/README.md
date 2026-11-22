# Connect to the cluster

Your workshop leader creates your team namespace and gives you a kubeconfig. Create `~/.kube` if needed and save it as `~/.kube/workshop.yaml`. Its context already selects your team's namespace.

```sh
chmod 600 ~/.kube/workshop.yaml
export KUBECONFIG="$HOME/.kube/workshop.yaml"
kubectl config current-context
kubectl config view --minify -o jsonpath='{.contexts[0].context.namespace}{"\n"}'
kubectl version
kubectl get pods
```

An empty pod list is fine. Use this namespace throughout the exercises. Ask your instructor for a new kubeconfig when the token expires.
