FROM centos:centos8

RUN yum -y install wget

RUN wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go1.15.6.linux-amd64.tar.gz

ENV PATH=$PATH:/usr/local/go/bin

RUN go version

ARG RELEASE_VERSION=v0.19.4

RUN curl -OJL https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu && \
  chmod +x operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu && \
  cp operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu /usr/local/bin/operator-sdk && \
  rm operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu

RUN yum install -y yum-utils && yum-config-manager --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo && \
    yum -y install docker-ce docker-ce-cli containerd.io

CMD [ "/bin/bash" ]
