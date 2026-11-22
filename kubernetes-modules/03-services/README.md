# Services

A ClusterIP Service gives the selected Pods a stable address inside the cluster. Use the team namespace selected in the [intro](../00-intro).

```sh
kubectl apply -f deployment-web.yaml -f service-clusterip.yaml
kubectl rollout status deployment/web-application --timeout=120s
kubectl get service web-application-int
kubectl get endpointslices -l kubernetes.io/service-name=web-application-int
kubectl port-forward service/web-application-int 8080:80
```

In another terminal, run `curl --fail http://localhost:8080/`. Use the [NetworkPolicy lab](../12-network-policies) to test access from inside the cluster.

Stop the port-forward and clean up.

```sh
kubectl delete -f service-clusterip.yaml -f deployment-web.yaml
```
