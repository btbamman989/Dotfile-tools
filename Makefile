SHELL := /bin/bash

# The directory of this file
DIR := $(shell echo $(shell cd "$(shell  dirname "${BASH_SOURCE[0]}" )" && pwd ))

# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

deploy: ## Run all roles
	ansible-playbook --ask-become-pass -i "localhost," -c local deploy.yml

deploy-server: ## Run the server role and all included roles
	ansible-playbook --ask-become-pass -i "localhost," -c local roles/server/tasks/main.yml

update-dotfiles: ## Update the dotfiles
	ansible-playbook --ask-become-pass -i "localhost," -c local roles/dotfiles/tasks/main.yml