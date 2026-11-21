# Serve a static page with NGINX

Copy `index.html` into an unprivileged NGINX image. Run these commands from [`container-modules/`](../README.md).

```sh
podman build -t workshop-nginx:v1 nginx
podman run --rm -p 127.0.0.1:8080:8080 workshop-nginx:v1
```

From another terminal, run `curl -fsS http://127.0.0.1:8080/`. The response contains `Ich bin eine Website in einem Container`. Stop the container with Ctrl+C before starting the next one.

Create `nginx/about.html` with your own text. Add `COPY --chmod=0644 about.html /usr/share/nginx/html/about.html` to `nginx/Dockerfile`. Rebuild and run the new tag.

```sh
podman build -t workshop-nginx:v2 nginx
podman run --rm -p 127.0.0.1:8080:8080 workshop-nginx:v2
```

From the second terminal, run `curl -fsS http://127.0.0.1:8080/about.html`. You should see the text from your new page. Stop the container when you’re done.
