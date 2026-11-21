FROM rust:1.100.0-slim-trixie@sha256:6f14b2b4b278ec0d50aa1d69541c304ce0f95e0f6268487aa9924af1c2e9aebe AS build

RUN --mount=type=bind,target=/src \
    cargo build --manifest-path /src/Cargo.toml --target-dir /target --locked --release

FROM debian:trixie-20261104-slim@sha256:a72b4433de1cf7d6bae0c4cee74d0547f58601a643b3375f070c51600d63b6b2

COPY --from=build --chmod=0755 /target/release/workshop-http /usr/local/bin/workshop-http
USER 65532:65532
EXPOSE 8080

ENTRYPOINT ["workshop-http"]
