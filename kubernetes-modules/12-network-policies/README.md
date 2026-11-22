# NetworkPolicy

Use a cluster that enforces NetworkPolicy. Deploy the app and [Red Hat UBI Toolbox](https://catalog.redhat.com/en/software/containers/ubi9/toolbox/61532d7dd2c7f84a4d2ed86b) next to each other in your team namespace.

```sh
kubectl apply -f deployment-web.yaml -f toolbox.yaml
kubectl rollout status deployment/network-demo --timeout=120s
kubectl rollout status deployment/toolbox --timeout=120s
```

Use Toolbox to resolve the Service name and make an HTTP request from inside the cluster.

```sh
kubectl exec deployment/toolbox -- getent hosts network-demo
kubectl exec deployment/toolbox -- curl -fsS --max-time 5 http://network-demo/ -o /dev/null
```

Apply the ingress deny policy and repeat both checks. DNS should still resolve. HTTP should time out once the policy takes effect.

```sh
kubectl apply -f deny-all.yaml
```

Apply the allow policy and repeat the checks. HTTP should work from pods labeled `app=toolbox` in the same namespace.

```sh
kubectl apply -f allow-toolbox.yaml
```

Clean up.

```sh
kubectl delete -f allow-toolbox.yaml -f deny-all.yaml -f toolbox.yaml -f deployment-web.yaml
```
