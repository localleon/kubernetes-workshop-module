# Java on minimal UBI

Use the smaller UBI base and install the JDK with `microdnf`. Run these commands from [`container-modules/`](../README.md).

```sh
podman build -f 02_Min_RHEL/Dockerfile-2 -t workshop-java:ubi-minimal .
podman run --rm workshop-java:ubi-minimal
```

The program prints the same greeting. Add `LABEL org.opencontainers.image.title="Workshop Java on minimal UBI"` to `02_Min_RHEL/Dockerfile-2`. Build a new tag and inspect the label.

```sh
podman build -f 02_Min_RHEL/Dockerfile-2 -t workshop-java:ubi-minimal-v2 .
podman image inspect --format '{{ index .Config.Labels "org.opencontainers.image.title" }}' workshop-java:ubi-minimal-v2
```
