#!/bin/bash

apt-get update && \
apt-get install -y --no-install-recommends \
libxslt && \
rm -rf /var/lib/apt/lists/*
