FROM docker.io/library/python:3.14.10-slim-trixie@sha256:9aaa474097d094040649f2162a627c0049b408f52138d980916788d80f04802f

WORKDIR /app
COPY --chmod=0644 app.py .
USER 65532:65532
EXPOSE 8080

CMD ["python", "-u", "app.py"]
