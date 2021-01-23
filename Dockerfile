FROM ubuntu:focal

EXPOSE 8001

# AZ CLI

WORKDIR /root

RUN apt-get update

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get install -y -q 

RUN apt-get install -y dialog apt-utils

RUN apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg libc6

RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ focal main" > /etc/apt/sources.list.d/azure-cli.list

RUN apt-get update

RUN apt-get install -y azure-cli

# KUBECTL

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
