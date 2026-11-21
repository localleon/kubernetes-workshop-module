# Build a Python HTTP server

Copy the script into a slim Python image and run it as a regular user. The server uses the Python standard library.

From [`container-modules/`](../README.md), build and run the image.

```sh
podman build -t workshop-python:v1 python
podman run --rm -p 127.0.0.1:8080:8080 workshop-python:v1
```

In a second terminal, run `curl -fsS http://127.0.0.1:8080/`. The response is `Hello from Python`.

Press Ctrl+C in the first terminal to stop the container.
