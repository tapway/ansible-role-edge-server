SHELL := /bin/bash
# https://www.gushiciku.cn/pl/p6TH
.SHELLFLAGS := -euo pipefail -c
.ONESHELL:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

IMAGE := gotapway/netdata-jetson
NETDATA_VERSION := $(shell python3 extract_version.py)


builder-init:  ## Setup for arm build
	@docker run --privileged --rm tonistiigi/binfmt --install arm64
	@if docker buildx inspect netdata-jetson > /dev/null 2>&1; then \
		echo "Builder instance 'netdata-jetson' already exists. Using the existing one."; \
		docker buildx use netdata-jetson; \
	else \
		echo "Creating new Buildx builder instance 'netdata-jetson'..."; \
		docker buildx create --use --platform=linux/arm64 --name netdata-jetson; \
	fi

update-netdata-image:  ## Update netdata base image
	sed -i 's/:.*/:v${NETDATA_VERSION}/' Dockerfile.netdata

init: builder-init update-netdata-image  ## all init steps at once

build:  ## Build and push netdata jetson image
	docker buildx build --platform arm64 --push -t ${IMAGE}:v${NETDATA_VERSION} -f Dockerfile.netdata .

.DEFAULT_GOAL := help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-24s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
