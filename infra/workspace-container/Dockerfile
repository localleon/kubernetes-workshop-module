FROM ubuntu

RUN apt-get update \
    && apt-get install -y \
    sudo \
    curl \
    git \
    bash-completion \
    cmake \
    coreutils \
    curl \
    findutils \
    jq \
    less \
    nano \
    nmap \
    openssl \
    openssh-client \
    python3 \
    python3-pip \
    python3-dev \
    ripgrep \
    rsync \
    sudo \
    tar \
    tree \
    tzdata \
    util-linux \
    yamllint \
    yq \
    unzip \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# install kubectl
RUN \
  curl -LsO https://storage.googleapis.com/kubernetes-release/release/$(curl -LsS https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
  chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl 

# install helm
RUN VERIFY_CHECKSUM=false curl -LsS https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash -s

# install terraform
# versioning info from
# https://github.com/devops-infra/docker-terragrunt/blob/master/Dockerfile
RUN \
  release=$( curl -LsS https://releases.hashicorp.com/terraform/ | grep -Eo '/[.0-9]+/' | grep -Eo '[.0-9]+' | sort -V | tail -1 ) && \
  curl -LsS https://releases.hashicorp.com/terraform/${release}/terraform_${release}_linux_amd64.zip -o terraform.zip && \
  unzip terraform.zip && rm terraform.zip && \
  mv terraform /usr/local/bin/terraform 

# Install K9s 
RUN curl -sLO https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.deb && sudo dpkg -i k9s_linux_amd64.deb

# Kyverno CLI 
RUN curl -LO https://github.com/kyverno/kyverno/releases/download/v1.12.0/kyverno-cli_v1.12.0_linux_x86_64.tar.gz && tar -xvf kyverno-cli_v1.12.0_linux_x86_64.tar.gz && cp kyverno /usr/local/bin/

ARG USER=coder
RUN useradd --groups sudo --shell /bin/bash ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
    && chmod 0440 /etc/sudoers.d/${USER}

# Fix Permissions for different apps 
RUN mkdir /home/coder && chown -R ${USER}:${USER} /home/${USER}

# Install BashRC for coder user and default ubuntu user
COPY .bashrc /home/${USER}/.bashrc 
COPY .bashrc /home/ubuntu/.bashrc 

USER ${USER}
WORKDIR /home/${USER}