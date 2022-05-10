FROM quay.io/fedora/fedora:36

LABEL org.opencontainers.image.authors="hayden@hbjy.dev"
LABEL org.opencontainers.image.source="https://github.com/hbjydev/dot"

RUN dnf update -y && \
    dnf install -y \
      ansible \
      openssh \
      dnf-plugins-core \
      git

WORKDIR /usr/local/share/workspace

COPY requirements.yaml .
RUN ansible-galaxy install -r requirements.yaml

ENV TERM=xterm-256color

COPY . .

# todo: find a better way to run this in a shell context (currently runs in sh)
RUN bash -c 'ansible-playbook --diff --extra-vars "@docker/values.yaml" ./main.yaml'

