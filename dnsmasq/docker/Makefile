include Makefile.dnsmasq

SHELL=bash

.DEFAULT_GOAL: build

.PHONY: build
build:
	set -euo pipefail ;\
	docker build -t $(DNSMASQ_IMAGE_NAME):latest . ;\
	docker run -it --rm -v $(CURDIR)/Makefile.version:/workspace/Makefile.version -w /workspace $(DNSMASQ_IMAGE_NAME):latest bash -c "echo -n 'DNSMASQ_VERSION=' >Makefile.version; dpkg -s dnsmasq | grep '^Version:' | cut -d' ' -f2 | cut -d'-' -f1 >>Makefile.version" ;\
	DNSMASQ_VERSION="$$(cut -d'=' -f2- Makefile.version)" ;\
	docker tag $(DNSMASQ_IMAGE_NAME):latest $(DNSMASQ_IMAGE_NAME):$${DNSMASQ_VERSION} ;\
	echo created image $(DNSMASQ_IMAGE_NAME):$${DNSMASQ_VERSION}

.PHONY: push
push:
	set -euo pipefail ;\
	echo "$(CR_PAT)" | docker login ghcr.io -u "$(CR_USERNAME)" --password-stdin
	DNSMASQ_VERSION="$$(cut -d'=' -f2- Makefile.version)" ;\
	docker tag $(DNSMASQ_IMAGE_NAME):$${DNSMASQ_VERSION} ghcr.io/$(DNSMASQ_IMAGE_NAME):$${DNSMASQ_VERSION} ;\
	docker push ghcr.io/$(DNSMASQ_IMAGE_NAME):$${DNSMASQ_VERSION}
