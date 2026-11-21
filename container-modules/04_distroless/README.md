# Java on Distroless

Build the JAR with the JDK, then copy it into a Distroless Java runtime. The final image has no shell.

From [`container-modules/`](../README.md), build and run the image.

```sh
podman build -f 04_distroless/Dockerfile-4 -t workshop-java:distroless .
podman run --rm workshop-java:distroless
```

The program prints `Hallo, ich bin eine Java App in einem Container` and exits. Use `podman image ls workshop-java` to compare the results.
