FROM php:8.1-bullseye as builder

WORKDIR /extension

COPY ./version ./

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libzip-dev && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install zip && \
    cp "$(php -r "echo ini_get ('extension_dir');")/zip.so" ./
COPY ./install* ./

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
