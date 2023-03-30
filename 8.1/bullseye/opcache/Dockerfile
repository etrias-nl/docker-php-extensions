FROM php:8.1-bullseye as builder

WORKDIR /extension

COPY ./version ./

RUN docker-php-ext-install opcache && \
    cp "$(php -r "echo ini_get ('extension_dir');")/opcache.so" ./
COPY ./install* ./

FROM alpine:3.17.3
COPY --from=builder /extension/ /extension/
