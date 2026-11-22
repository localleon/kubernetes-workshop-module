# Kyverno

Kyverno checks resources as they enter the cluster. This policy requires a label on Pods in your namespace.

Apply the policy in audit mode and create the unlabeled Pod. Kyverno lets it through and records the failure. The report can take a moment to appear.

```sh
kubectl apply -f label-policy.yaml
kubectl apply -f pod.yaml
kubectl get policyreports -o yaml
```

Delete the Pod, change `validationActions` in `label-policy.yaml` to `[Deny]`, and apply it again. After the policy is ready, the Pod should be rejected.

```sh
kubectl delete -f pod.yaml
kubectl apply -f label-policy.yaml
kubectl get namespacedvalidatingpolicy require-labels
kubectl apply -f pod.yaml
```

Add `app.kubernetes.io/name: policy-demo` under the Pod's `metadata.labels` and apply it again. Then clean up.

```sh
kubectl apply -f pod.yaml
kubectl delete -f pod.yaml -f label-policy.yaml
```
