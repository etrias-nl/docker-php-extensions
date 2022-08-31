#!/bin/bash

apt-get update && \
apt-get install -y --no-install-recommends \
jpegoptim \
libbsd-dev \
ghostscript \
libgraphicsmagick-q16-3 && \
rm -rf /var/lib/apt/lists/*

DIR=$(dirname "$(readlink -f "$0")")

cp -R "$DIR"/lib/* /usr/local/lib
cp -R "$DIR"/share/* /usr/local/share/
cp "$DIR"/bin/* /usr/local/bin/
