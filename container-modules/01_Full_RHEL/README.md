# Java on standard UBI

Install the JDK on Red Hat Universal Base Image, compile the program, and run it as a regular user.

From [`container-modules/`](../README.md), build and run the image.

```sh
podman build -f 01_Full_RHEL/Dockerfile-1 -t workshop-java:ubi .
podman run --rm workshop-java:ubi
```

The program prints `Hallo, ich bin eine Java App in einem Container` and exits. Use `podman image ls workshop-java` to compare the results.
