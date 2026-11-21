FROM docker.io/library/ubuntu:24.04@sha256:9c7f200c07e3d4a03e7249d2c16bf66a51120fb876aa2242cf31451412543289

ARG KUBECTL_VERSION=v1.36.6
ARG K9S_VERSION=v0.51.0
ARG KYVERNO_VERSION=v1.20.0
ARG CODE_SERVER_VERSION=4.146.0
ARG K9S_SHA256=c3752ad51a5a4015a113819c4eeb6e55a4d0e4b8e652494797532f6fc8161dd7
ARG KYVERNO_SHA256=06b8f3ca7b5626473be8fb4d343ad54ab84e317142766f72420e7d44b80942e2
ARG CODE_SERVER_SHA256=cf7e82ca5fe1df664d43a43d900c3c9710f8f3403a5e8d0e18f6a12d10d7401b

COPY .bashrc /etc/skel/.bashrc

RUN set -eu; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
      bash-completion ca-certificates curl dnsutils git jq less nano openssh-client \
      iptables netavark podman sudo tzdata; \
    rm -rf /var/lib/apt/lists/*; \
    kubectl_url="https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"; \
    curl -fsSLo /tmp/kubectl "$kubectl_url"; \
    curl -fsSLo /tmp/kubectl.sha256 "$kubectl_url.sha256"; \
    printf '%s  /tmp/kubectl\n' "$(cat /tmp/kubectl.sha256)" | sha256sum -c -; \
    install -m 0755 /tmp/kubectl /usr/local/bin/kubectl; \
    rm /tmp/kubectl /tmp/kubectl.sha256; \
    curl -fsSLo /tmp/k9s.tar.gz "https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz"; \
    printf '%s  /tmp/k9s.tar.gz\n' "${K9S_SHA256}" | sha256sum -c -; \
    tar -xzf /tmp/k9s.tar.gz -C /usr/local/bin k9s; \
    curl -fsSLo /tmp/kyverno.tar.gz "https://github.com/kyverno/kyverno/releases/download/${KYVERNO_VERSION}/kyverno-cli_${KYVERNO_VERSION}_linux_x86_64.tar.gz"; \
    printf '%s  /tmp/kyverno.tar.gz\n' "${KYVERNO_SHA256}" | sha256sum -c -; \
    tar -xzf /tmp/kyverno.tar.gz -C /usr/local/bin kyverno; \
    curl -fsSLo /tmp/code-server.tar.gz "https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server-${CODE_SERVER_VERSION}-linux-amd64.tar.gz"; \
    printf '%s  /tmp/code-server.tar.gz\n' "${CODE_SERVER_SHA256}" | sha256sum -c -; \
    mkdir -p /opt/code-server; \
    tar -xzf /tmp/code-server.tar.gz -C /opt/code-server --strip-components=1; \
    ln -s /opt/code-server/bin/code-server /usr/local/bin/code-server; \
    rm /tmp/k9s.tar.gz /tmp/kyverno.tar.gz /tmp/code-server.tar.gz; \
    usermod --login coder --move-home --home /home/coder --shell /bin/bash ubuntu && \
    groupmod --new-name coder ubuntu && \
    usermod --append --groups sudo coder && \
    printf 'coder ALL=(ALL) NOPASSWD:ALL\n' > /etc/sudoers.d/coder && \
    chmod 0440 /etc/sudoers.d/coder && \
    install -o coder -g coder -m 0644 /etc/skel/.bashrc /home/coder/.bashrc

COPY podman.conf /etc/containers/containers.conf.d/90-workshop.conf

USER coder
WORKDIR /home/coder
