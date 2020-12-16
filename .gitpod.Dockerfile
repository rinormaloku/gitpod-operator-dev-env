FROM gitpod/workspace-full:latest

USER gitpod

RUN sudo apt-get update
RUN sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

RUN curl -OJL https://golang.org/dl/go1.15.6.linux-amd64.tar.gz && \
  sudo tar -C /usr/local -xzf go1.15.6.linux-amd64.tar.gz

ENV PATH=$PATH:/usr/local/go/bin

RUN go version

ARG RELEASE_VERSION=v0.19.4
RUN curl -OJL https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu
RUN chmod +x operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu
RUN sudo cp operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu /usr/local/bin/operator-sdk

RUN sudo apt update
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RUN sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
RUN sudo apt update
RUN sudo apt -y install docker-ce

ARG VERSION_ID="20.04"

RUN echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
RUN curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | sudo apt-key add -
RUN sudo apt-get update
RUN sudo apt-get -y upgrade
RUN sudo apt-get -y install podman


RUN sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
RUN sudo apt-get update
RUN sudo apt-get install -y kubectl
