# Build a container image

Install [Podman](https://podman.io/docs/installation), then run these commands from `container-modules/`. Use your own machine or an instructor-provided Linux build workspace.

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
podman build -f "$DOCKERFILE" -t workshop-java:v1 .
podman run --rm workshop-java:v1
podman image ls workshop-java
```

Each prints `Hallo, ich bin eine Java App in einem Container`. Compare the image sizes after each build.

## NGINX, Rust, and Python

Set `EXAMPLE` to `nginx`, `rust`, or `python`.

```sh
EXAMPLE=python
podman build -t "workshop-$EXAMPLE:v1" "$EXAMPLE"
podman run --rm -p 127.0.0.1:8080:8080 "workshop-$EXAMPLE:v1"
```

In another terminal, run `curl -fsS http://127.0.0.1:8080/`. Stop the container with Ctrl+C.
