# syntax=docker/dockerfile:1.5

FROM python:3.11.6-slim-bullseye  AS base

ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/root/.cache/apt <<EOF
    apt-get update
    apt-get install -y --no-install-recommends ssh
    apt-get -y clean
    apt-get -y autoremove
    rm -rf /var/lib/apt/lists/*
EOF

RUN --mount=type=cache,target=/root/.cache/pip <<EOF
    pip install --upgrade pip
    pip install ansible
EOF

COPY . .
WORKDIR /edge-server/tests
CMD ansible-playbook test.yml
