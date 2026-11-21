FROM docker.io/nginx/nginx-unprivileged:1.30.7-alpine@sha256:0c53a1f2890c3526bfd201440f0fd3970e5b78f80630f58284aad0d34b5ec7bd

COPY --chmod=0644 index.html /usr/share/nginx/html/index.html
USER 101:101
