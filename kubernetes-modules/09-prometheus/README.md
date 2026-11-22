# Prometheus

A ServiceMonitor tells Prometheus which Service to scrape and which port and path to use.

```sh
kubectl apply -f service-monitors/
kubectl rollout status deployment/metrics-app --timeout=120s
kubectl get servicemonitor metrics-app-monitor
kubectl port-forward service/metrics-app-service 8080:8080
```

In a second terminal, confirm the app exposes metrics.

```sh
curl --fail http://localhost:8080/metrics
```

The instructor can open Prometheus **Status → Targets** and find `metrics-app-service` in your team namespace. Run `up{service="metrics-app-service"}` to see whether scrapes succeed.

Stop the port-forward, then clean up.

```sh
kubectl delete -f service-monitors/
```
