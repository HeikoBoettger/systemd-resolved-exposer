SHELL=/bin/bash
.DEFAULT_GOAL=build

DNSMASQ_VERSION=2.89

.PHONY: create-build-environment
create-build-environment:
	cd docker; docker build -t dnsmasq-build:latest .

.PHONY: fetch
fetch: tmp/dnsmasq-$(DNSMASQ_VERSION)

tmp/dnsmasq-2.89:
	set -euo pipefail ;\
	mkdir -p tmp ;\
	pushd tmp >/dev/null ;\
	curl -fsLS -o dnsmasq-$(DNSMASQ_VERSION).tar.gz https://thekelleys.org.uk/dnsmasq/dnsmasq-$(DNSMASQ_VERSION).tar.gz ;\
	tar -xzf dnsmasq-$(DNSMASQ_VERSION).tar.gz ; \
	rm dnsmasq-$(DNSMASQ_VERSION).tar.gz; \
	popd >/dev/null

.PHONY: build
build: fetch create-build-environment
	set -euo pipefail ;\
	mkdir -p out ;\
	mkdir -p tmp ;\
	docker volume create --driver lebokus/bindfs -o sourcePath=$(CURDIR) -o map=$$(id -u)/0:@$$(id -g)/@0 dnsmasq-workspace ;\
	docker run -it --rm -e DNSMASQ_VERSION=$(DNSMASQ_VERSION) -v dnsmasq-workspace:/workspace dnsmasq-build:latest build.sh ;\
	docker volume rm dnsmasq-workspace

.PHONY: clean-build-environment
clean-build-environment:
	docker image rm dnsmasq-build:latest || true

.PHONY: clean
clean: clean-build-environment
	set -euo pipefail ;\
	docker volume rm dnsmasq-workspace || true ;\
	rm -rf tmp ;\
	rm -rf out
