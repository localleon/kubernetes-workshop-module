# Build a Rust HTTP server

Compile the server in a build stage and copy the binary into a slim runtime image. Run these commands from [`container-modules/`](../README.md).

```sh
podman build -t workshop-rust:v1 rust
podman run --rm -p 127.0.0.1:8080:8080 workshop-rust:v1
```

From another terminal, run `curl -fsS http://127.0.0.1:8080/`. The response is `Hello from Rust`. Stop the container with Ctrl+C before starting the next one.

Change the greeting in `rust/src/main.rs`. Rebuild and run the new tag so the Rust build picks up that change.

```sh
podman build -t workshop-rust:v2 rust
podman run --rm -p 127.0.0.1:8080:8080 workshop-rust:v2
```

From the second terminal, run `curl -fsS http://127.0.0.1:8080/`. You should see your new greeting. Stop the container when you’re done.
