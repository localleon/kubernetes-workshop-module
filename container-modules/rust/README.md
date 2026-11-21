# Build a Rust HTTP server

Compile the server in a Rust build stage and copy the binary into a slim runtime image. The server uses the Rust standard library.

From [`container-modules/`](../README.md), build and run the image.

```sh
podman build -t workshop-rust:v1 rust
podman run --rm -p 127.0.0.1:8080:8080 workshop-rust:v1
```

In a second terminal, run `curl -fsS http://127.0.0.1:8080/`. The response is `Hello from Rust`.

Press Ctrl+C in the first terminal to stop the container.
