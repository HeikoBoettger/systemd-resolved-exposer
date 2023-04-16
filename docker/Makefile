SHELL=bash

CONTAINER_IMAGE=heboettger/systemd-resolved-exposer
CONTAINER_NAME=systemd-resolved-exposer

.DEFAULT_GOAL: build

.PHONY: build
build:
	docker build -t $(CONTAINER_IMAGE) .

.PHONY: .run-container
.run-container:
	set -euo pipefail ;\
	docker rename $(CONTAINER_NAME) $(CONTAINER_NAME).old || true ;\
	docker run $(ADDITIONAL_DOCKER_ARGS) --cap-add NET_ADMIN --name $(CONTAINER_NAME) --network=host $(CONTAINER_IMAGE) -k ;\
	docker container rm $(CONTAINER_NAME).old || true


.PHONY: run-as-service
run-as-service: ADDITIONAL_DOCKER_ARGS=-d --restart unless-stopped
run-as-service: .run-container

.PHONY: run
run: ADDITIONAL_DOCKER_ARGS=-it --rm
run: .run-container

.PHONY: stop
stop:
	docker stop $(CONTAINER_NAME) || true

