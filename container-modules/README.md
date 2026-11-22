# Build containers

Open a terminal in `container-modules/`. On your machine, install [Podman](https://podman.io/docs/installation). In Coder, select **Enable Podman** in your lab workspace and prefix each `podman` command with `sudo`.

Each tutorial starts with a working image and walks you through a change you can verify.

## Java

Build the same program with each base image. Run `podman image ls workshop-java` to compare their sizes.

- [Standard UBI](01_Full_RHEL/README.md)
- [Minimal UBI](02_Min_RHEL/README.md)
- [Multi-stage with the UBI OpenJDK runtime](03_Multi_Stage_Java/README.md)
- [Multi-stage with Distroless](04_distroless/README.md)

## HTTP

- [NGINX static site](nginx/README.md)
- [Rust HTTP server](rust/README.md)
- [Python HTTP server](python/README.md)
