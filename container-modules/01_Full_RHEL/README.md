# Java on standard UBI

Build the Java program on Red Hat Universal Base Image. Run these commands from [`container-modules/`](../README.md).

```sh
podman build -f 01_Full_RHEL/Dockerfile-1 -t workshop-java:ubi .
podman run --rm workshop-java:ubi
```

The program prints a greeting. In `01_Full_RHEL/Dockerfile-1`, add `jq` to the existing `dnf install` command. Rebuild under a new tag and check that the package is available.

```sh
podman build -f 01_Full_RHEL/Dockerfile-1 -t workshop-java:ubi-jq .
podman run --rm workshop-java:ubi-jq jq --version
```
