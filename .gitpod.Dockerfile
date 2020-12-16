FROM debian:stable

RUN apt-get update
RUN apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

RUN curl -OJL https://golang.org/dl/go1.15.6.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go1.15.6.linux-amd64.tar.gz

ENV PATH=$PATH:/usr/local/go/bin

RUN go version

ARG RELEASE_VERSION=v0.19.4


RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

RUN apt-get update
RUN apt-get -y install docker-ce docker-ce-cli containerd.io

