# Java on Distroless

Build the JAR with the JDK and copy it into a Distroless Java runtime. Run these commands from [`container-modules/`](../README.md).

```sh
podman build -f 04_distroless/Dockerfile-4 -t workshop-java:distroless .
podman run --rm workshop-java:distroless
```

Add `ENV JAVA_TOOL_OPTIONS="-Xmx64m"` to the final stage in `04_distroless/Dockerfile-4`. Rebuild and run the image. Java should report the option before printing the greeting.

```sh
podman build -f 04_distroless/Dockerfile-4 -t workshop-java:distroless-v2 .
podman run --rm workshop-java:distroless-v2
```
