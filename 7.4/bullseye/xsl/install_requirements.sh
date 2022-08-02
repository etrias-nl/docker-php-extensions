#!/bin/bash

apt-get update && \
apt-get install -y --no-install-recommends \
libxslt1-dev && \
rm -rf /var/lib/apt/lists/*
