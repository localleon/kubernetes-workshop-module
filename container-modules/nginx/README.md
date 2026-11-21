# Serve a static page with NGINX

Copy `index.html` into an unprivileged NGINX image. The container listens on port 8080.

From [`container-modules/`](../README.md), build and run the image.

```sh
podman build -t workshop-nginx:v1 nginx
podman run --rm -p 127.0.0.1:8080:8080 workshop-nginx:v1
```

In a second terminal, run `curl -fsS http://127.0.0.1:8080/`. The response contains `Ich bin eine Website in einem Container`.

Press Ctrl+C in the first terminal to stop the container.
