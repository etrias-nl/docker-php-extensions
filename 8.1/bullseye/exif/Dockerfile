FROM php:8.1-bullseye as builder

WORKDIR /extension

COPY ./version ./

RUN docker-php-ext-install exif && \
    cp "$(php -r "echo ini_get ('extension_dir');")/exif.so" ./
COPY ./install* ./

FROM alpine:3.17.3
COPY --from=builder /extension/ /extension/
