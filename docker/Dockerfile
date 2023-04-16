ARG DNSMASQ_IMAGE
FROM ${DNSMASQ_IMAGE}

RUN apt-get update && \
    apt-get install -y iproute2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY dnsmasq.conf /etc/dnsmasq.conf
COPY entrypoint.sh /usr/bin/entrypoint.sh

ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
