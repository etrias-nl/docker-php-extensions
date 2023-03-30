FROM php:7.4-bullseye as builder

WORKDIR /extension

COPY ./version ./

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libjudy-dev && \
    rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3003
RUN cd /tmp \
    && curl -L "https://github.com/BitOne/php-meminfo/archive/refs/tags/v$(cat /extension/version).tar.gz" --output /tmp/php-meminfo.tar.gz \
    && tar -xf php-meminfo.tar.gz \
    && cd php-meminfo-*/extension/php7 \
    && phpize \
    && ./configure --enable-meminfo\
    && make \
    && make install \
    && cp ./modules/meminfo.so /extension \
    && rm -rf /tmp/php-memory-profiler*

COPY ./install* /extension/

FROM alpine:3.17.3
COPY --from=builder /extension/ /extension/
