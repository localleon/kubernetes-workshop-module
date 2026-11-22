# Build a Python HTTP server

Copy the script into a slim Python image and run it as a regular user. Run these commands from [`container-modules/`](../README.md).

```sh
podman build -t workshop-python:v1 python
podman run --rm -p 127.0.0.1:8080:8080 workshop-python:v1
```

From another terminal, run `curl -fsS http://127.0.0.1:8080/`. The response is `Hello from Python`. Stop the container with Ctrl+C before starting the next one.

In `python/app.py`, add `self.send_header("X-Workshop", "python")` just before `self.end_headers()`. Rebuild and run the new tag.

```sh
podman build -t workshop-python:v2 python
podman run --rm -p 127.0.0.1:8080:8080 workshop-python:v2
```

From the second terminal, run `curl -fsSi http://127.0.0.1:8080/`. Look for `X-Workshop: python` in the response headers. Stop the container when you’re done.
