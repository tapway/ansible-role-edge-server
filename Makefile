SHELL := /bin/bash
# https://www.gushiciku.cn/pl/p6TH
.SHELLFLAGS := -euo pipefail -c
.ONESHELL:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ROOT := $(shell pwd)
IMAGE := gotapway/ansible-role-edge-server
VERSION := prod
# Get the current year and week number
YEAR := $(shell date +%Y)
WEEK := $(shell date +%-V)
DAY := $(shell date +%u)
# Define the tag format
TAG := $(YEAR).$(WEEK).$(DAY)

.DEFAULT_GOAL = help

##@ Bootstrap
.PHONY: repo-init init

repo-init:  ## Install pre-commit in repo
	pre-commit install -t pre-commit -t commit-msg

init: repo-init  ## All init steps at once

##@ Checks
.PHONY: check test

check:  ## Run pre-commit against all files
	pre-commit run --all-files

test:  ## Run playbook
	 ANSIBLE_CONFIG=./edge-server/tests/ansible.cfg ansible-playbook -i inventory.yml ./edge-server/tests/playbook.yml

##@ Docker
.PHONY: tag builder-init build

tag:  ## Display current TAG
	@echo "Current TAG: $(TAG)"

builder-init:  ## Setup for amd and arm build
	@docker run --privileged --rm tonistiigi/binfmt --install arm64, amd64
	@if docker buildx inspect edge-server > /dev/null 2>&1; then \
		echo "Builder instance 'edge-server' already exists. Using the existing one."; \
		docker buildx use edge-server; \
	else \
		echo "Creating new Buildx builder instance 'edge-server'..."; \
		docker buildx create --use --platform=linux/arm64 --name edge-server; \
	fi

build-stg: builder-init  ## Build and push ansible role edge server image
	docker buildx build --platform arm64,amd64 --push -t ${IMAGE}:dev -t ${IMAGE}:${TAG}-stg -f Dockerfile .

build-prod: builder-init  ## Build and push ansible role edge server image
	docker buildx build --platform arm64,amd64 --push -t ${IMAGE}:prod -t ${IMAGE}:${TAG}-prod -f Dockerfile .

##@ Miscellaneous
.PHONY: secrets-baseline-create secrets-baseline-audit secrets-update

secrets-baseline-create:  ## Create/update .secrets.baseline file
	detect-secrets scan --baseline .secrets.baseline

secrets-baseline-audit:  ## Check updated .secrets.baseline file
	detect-secrets audit .secrets.baseline
	git commit .secrets.baseline --no-verify -m "build(security): update secrets.baseline"

secrets-update: secrets-baseline-create secrets-baseline-audit  ## Update secrets baseline file

##@ Helpers
.PHONY: help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-24s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
