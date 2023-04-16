include ../dnsmasq/docker/Makefile.dnsmasq

SHELL=bash

EXPOSER_IMAGE_NAME=heikoboettger/systemd-resolved-exposer
EXPOSER_VERSION=1.0.0
EXPOSER_IMAGE=heikoboettger/systemd-resolved-exposer:$(EXPOSER_VERSION)
EXPOSER_CONTAINER_NAME=systemd-resolved-exposer

.DEFAULT_GOAL: build

.PHONY: build
build:
	docker build --build-arg "DNSMASQ_IMAGE=$(DNSMASQ_IMAGE)" -t $(EXPOSER_IMAGE) .

.PHONY: push
push:
	set -euo pipefail ;\
	echo "$(CR_PAT)" | docker login ghcr.io -u "$(CR_USERNAME)" --password-stdin
	docker tag $(EXPOSER_IMAGE) ghcr.io/$(EXPOSER_IMAGE) ;\
	docker push ghcr.io/$(EXPOSER_IMAGE)

.PHONY: .run-container
.run-container:
	set -euo pipefail ;\
	docker rename $(EXPOSER_CONTAINER_NAME) $(EXPOSER_CONTAINER_NAME).old || true ;\
	docker container stop $(EXPOSER_CONTAINER_NAME).old || true ;\
	docker run $(ADDITIONAL_DOCKER_ARGS) --cap-add NET_ADMIN --name $(EXPOSER_CONTAINER_NAME) --network=host $(EXPOSER_IMAGE) -k ;\
	docker container rm $(EXPOSER_CONTAINER_NAME).old || true


.PHONY: run-as-service
run-as-service: ADDITIONAL_DOCKER_ARGS=-d --restart unless-stopped
run-as-service: .run-container

.PHONY: run
run: ADDITIONAL_DOCKER_ARGS=-it --rm
run: .run-container

.PHONY: stop
stop:
	docker stop $(EXPOSER_CONTAINER_NAME) || true

