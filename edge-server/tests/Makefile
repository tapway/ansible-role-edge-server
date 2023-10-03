SHELL := /bin/bash
# https://www.gushiciku.cn/pl/p6TH
.SHELLFLAGS := -euo pipefail -c
.ONESHELL:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

.DEFAULT_GOAL = help

##@ CPU
.PONY: vagrant-up vagrant-play vagrant-destroy

vagrant-up:  ## Create VM
	vagrant up

vagrant-play:  ## Run test.yml playbook
	ansible-playbook test.yml --limit cpu

vagrant-destroy:  ## Destroy VM
	vagrant destroy -f

##@ GPU
.PONY: ec2-play

ec2-play:  ## Run test.yml playbook
	ansible-playbook test.yml --limit gpu

##@ Tests
.PONY: tests test-cpu test-gpu

test-cpu: vagrant-up vagrant-play vagrant-destroy  ## Create VM, run ansible role, and clean up
test-gpu: ec2-play   ## Run ansible role

tests: test-cpu test-gpu  ## Run all tests

##@ Helpers
.PHONY: help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-24s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
