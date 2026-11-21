# Java with a separate runtime

Build the JAR in an OpenJDK development image. Copy the JAR into a smaller OpenJDK runtime image.

From [`container-modules/`](../README.md), build and run the image.

```sh
podman build -f 03_Multi_Stage_Java/Dockerfile -t workshop-java:ubi-runtime .
podman run --rm workshop-java:ubi-runtime
```

The program prints `Hallo, ich bin eine Java App in einem Container` and exits. Use `podman image ls workshop-java` to compare the results.
