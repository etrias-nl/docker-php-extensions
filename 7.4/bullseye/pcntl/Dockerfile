FROM php:8.2-bullseye as builder

WORKDIR /extension

COPY ./version ./

RUN docker-php-ext-install pcntl && \
    cp "$(php -r "echo ini_get ('extension_dir');")/pcntl.so" ./
COPY ./install* ./

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
