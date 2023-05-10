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
    && curl -L "https://github.com/arnaud-lb/php-memory-profiler/archive/refs/tags/$(cat /extension/version).tar.gz" --output /tmp/php-memory-profiler.tar.gz \
    && tar -xf php-memory-profiler.tar.gz \
    && cd php-memory-profiler-* \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && cp ./modules/memprof.so /extension \
    && rm -rf /tmp/php-memory-profiler*

COPY ./install* /extension/

FROM alpine:3.18.0
COPY --from=builder /extension/ /extension/
