# Build a container image

Run these commands from `container-modules/` on a machine with Docker.

## Java

Set `DOCKERFILE` to one of the four choices.

| Image | Dockerfile |
| --- | --- |
| UBI standard | `01_Full_RHEL/Dockerfile-1` |
| UBI minimal | `02_Min_RHEL/Dockerfile-2` |
| UBI OpenJDK runtime | `03_Multi_Stage_Java/Dockerfile` |
| Distroless | `04_distroless/Dockerfile-4` |

```sh
DOCKERFILE=03_Multi_Stage_Java/Dockerfile
docker build -f "$DOCKERFILE" -t workshop-java:v1 .
docker run --rm workshop-java:v1
```

Each prints `Hallo, ich bin eine Java App in einem Container`. Try `docker image ls workshop-java` after each build to compare sizes.

## NGINX, Rust, and Python

Set `EXAMPLE` to `nginx`, `rust`, or `python`. Run `curl` in another terminal, then stop the container with Ctrl+C.

```sh
EXAMPLE=python
docker build -t "workshop-$EXAMPLE:v1" "$EXAMPLE"
docker run --rm -p 127.0.0.1:8080:8080 "workshop-$EXAMPLE:v1"
curl -fsS http://127.0.0.1:8080/
```

NGINX serves an HTML page. Rust and Python return a short greeting and use only their standard libraries.

## Deploy the Python image

With a local kind cluster, load the image and use the manifests:

```sh
kind load docker-image workshop-python:v1
kubectl apply -f python/deployment.yaml -f python/service.yaml
```

With Coder, build and push from your Docker machine to a registry the lab cluster can pull from. Use your own repository name and match the build platform to the cluster nodes.

```sh
IMAGE=ghcr.io/your-account/workshop-python:v1
docker buildx build --platform linux/amd64 --push -t "$IMAGE" python
```

In Coder, set `IMAGE` to the same value and apply to your workshop namespace:

```sh
kubectl set image --local -f python/deployment.yaml python="$IMAGE" -o yaml | kubectl apply -f -
kubectl apply -f python/service.yaml
```

Check and clean up from the terminal with your cluster credentials:

```sh
kubectl rollout status deployment/workshop-python --timeout=90s
kubectl port-forward service/workshop-python 8080:8080
# In another terminal, with the port-forward still running:
curl -fsS http://127.0.0.1:8080/
kubectl delete deployment,service workshop-python
```
