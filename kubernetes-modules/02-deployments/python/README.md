# Deploy your own image

Build the Python image in the [container module](../../../container-modules/README.md). Use a registry that your team namespace can pull from.

On the machine where you built the image, sign in to your registry and push it. Replace the registry and repository below. The image must match the cluster's CPU architecture. In Coder, prefix each `podman` command with `sudo`.

```sh
IMAGE=ghcr.io/your-account/workshop-python:v1
podman login ghcr.io
podman tag workshop-python:v1 "$IMAGE"
podman push "$IMAGE"
```

In your Kubernetes terminal, set `IMAGE` to the same value.

```sh
kubectl set image --local -f deployment.yaml python="$IMAGE" -o yaml | kubectl apply -f -
kubectl apply -f service.yaml
kubectl rollout status deployment/workshop-python --timeout=120s
kubectl port-forward service/workshop-python 8080:8080
```

Check with `curl -fsS http://127.0.0.1:8080/` in another terminal. Stop port-forwarding, then run `kubectl delete -f deployment.yaml -f service.yaml`.
