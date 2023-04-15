FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y curl build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY build.sh /usr/bin/build.sh

