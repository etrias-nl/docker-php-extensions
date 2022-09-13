#!/bin/bash

apt-get update && \
apt-get install -y --no-install-recommends \
libzip-dev \
unzip && \
rm -rf /var/lib/apt/lists/*
