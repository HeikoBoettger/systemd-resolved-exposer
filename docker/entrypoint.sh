#!/bin/bash

set -euo pipefail

BRIDGE_NAME="${BRIDGE_NAME:-br-resolv}"
BRIDGE_IP_ADDR_SUBNET="${BRIDGE_IP_ADDR_SUBNET:-100.65.0.1/24}"
DNS_SERVER_IP_ADDR="${DNS_SERVER_IP_ADDR:-127.0.0.53}"

ip link add "${BRIDGE_NAME}" type bridge || true
ip addr add "${BRIDGE_IP_ADDR_SUBNET}" dev "${BRIDGE_NAME}" || true
ip link set "${BRIDGE_NAME}" up || true

echo "listen-address=${BRIDGE_IP_ADDR_SUBNET/\/*/}" >/etc/dnsmasq.d/bridge.conf
echo "server=${DNS_SERVER_IP_ADDR}" >>/etc/dnsmasq.d/bridge.conf

exec dnsmasq "${@}"

