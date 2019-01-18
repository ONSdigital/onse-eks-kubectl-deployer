FROM ubuntu:16.04

RUN mkdir /etc/go

ENV GOPATH=/etc/go
ENV PATH=$PATH:${GOPATH}/bin

RUN apt-get update && apt-get install -y apt-transport-https curl golang gnupg git && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubectl

RUN go get gopkg.in/mikefarah/yq.v2

RUN mkdir -p /root/.kube/

COPY kubeconf.yml /root/.kube/config

ADD https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64 /usr/local/bin/aws-iam-authenticator

RUN chmod +x /usr/local/bin/aws-iam-authenticator
