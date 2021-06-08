#!/usr/bin/env make

.DEFAULT_SHELL := /bin/sh
.DEFAULT_GOAL  := help

DOCKER_REGISTRY_DOMAIN    := docker.io
DOCKER_REGISTRY_NAMESPACE := jjuarez
DOCKER_IMAGE_NAME         := docker-sinatra-app
DOCKER_IMAGE_TAG          := latest
DOCKER_FILE               ?= Dockerfile
DOCKER_CONTEXT            ?= .


.PHONY: help
help: ## Shows this pretty screen
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make <target>\n\nTargets:\n"} /^[a-zA-Z//_-]+:.*?##/ { printf " %-15s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: docker/build
docker/build: ## Builds the Docker image
	@docker image build -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) --file $(DOCKER_FILE) $(DOCKER_CONTEXT)
	@docker image tag $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) "$(DOCKER_REGISTRY_DOMAIN)/$(DOCKER_REGISTRY_NAMESPACE)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)"

.PHONY: docker/run
docker/run: ## Runs the compose scenario
	@docker compose up -d

.PHONY: docker/stop
docker/stop: ## Runs the compose scenario
	@docker compose down
