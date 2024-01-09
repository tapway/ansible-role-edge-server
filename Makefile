SHELL := /bin/bash
# https://www.gushiciku.cn/pl/p6TH
.SHELLFLAGS := -euo pipefail -c
.ONESHELL:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ROOT := $(shell pwd)

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
