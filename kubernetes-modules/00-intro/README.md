# Connect to the cluster

Use the kubeconfig provided by your instructor. Its context already selects your team namespace.

```sh
export KUBECONFIG="$HOME/.kube/workshop.yaml"
kubectl config current-context
kubectl config view --minify -o jsonpath='{.contexts[0].context.namespace}{"\n"}'
kubectl version
kubectl get pods
```

An empty pod list is fine. Use this namespace throughout the exercises. Ask your instructor for a new kubeconfig when the token expires.
