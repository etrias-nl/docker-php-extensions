FROM php:7.4-bullseye as builder

WORKDIR /extension

COPY ./version ./

RUN docker-php-ext-install pcntl && \
    cp "$(php -r "echo ini_get ('extension_dir');")/pcntl.so" ./
COPY ./install* ./

FROM alpine:3.17.3
COPY --from=builder /extension/ /extension/
