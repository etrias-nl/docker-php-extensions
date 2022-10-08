#!/bin/bash

apt-get update && \
apt-get install -y --no-install-recommends \
libjudy-dev && \
rm -rf /var/lib/apt/lists/*
