#!/bin/bash

set -euo pipefail

cd /workspace/tmp/dnsmasq-${DNSMASQ_VERSION}
make
make DESTDIR=/workspace/out install

