# Java with a separate runtime

Build the JAR with the JDK, then copy it into the OpenJDK runtime image. Run these commands from [`container-modules/`](../README.md).

```sh
podman build -f 03_Multi_Stage_Java/Dockerfile -t workshop-java:ubi-runtime .
podman run --rm workshop-java:ubi-runtime
```

Change `USER 185:0` to `USER 1001:0` in `03_Multi_Stage_Java/Dockerfile`. Rebuild and check the configured user. The greeting should still print.

```sh
podman build -f 03_Multi_Stage_Java/Dockerfile -t workshop-java:ubi-runtime-v2 .
podman image inspect --format '{{.Config.User}}' workshop-java:ubi-runtime-v2
podman run --rm workshop-java:ubi-runtime-v2
```
