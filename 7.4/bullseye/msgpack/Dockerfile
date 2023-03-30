FROM php:7.4-bullseye as builder

WORKDIR /extension

COPY ./version ./

# hadolint ignore=DL3003
RUN cd /tmp \
    && curl -L "https://github.com/msgpack/msgpack-php/archive/refs/tags/msgpack-$(cat /extension/version).tar.gz" --output /tmp/msgpack-php.tar.gz \
    && tar -xf msgpack-php.tar.gz \
    && cd msgpack-php-* \
    && phpize \
    && ./configure \
    && make \
    && make install  \
    && cp ./modules/msgpack.so /extension \
    && rm -rf /tmp/msgpack*

COPY ./install* /extension/

FROM alpine:3.17.3
COPY --from=builder /extension/ /extension/
