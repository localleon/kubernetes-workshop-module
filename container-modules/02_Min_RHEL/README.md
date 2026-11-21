# Java on minimal UBI

Use the smaller UBI base and install the JDK with `microdnf`. The same program runs as a regular user.

From [`container-modules/`](../README.md), build and run the image.

```sh
podman build -f 02_Min_RHEL/Dockerfile-2 -t workshop-java:ubi-minimal .
podman run --rm workshop-java:ubi-minimal
```

The program prints `Hallo, ich bin eine Java App in einem Container` and exits. Use `podman image ls workshop-java` to compare the results.
