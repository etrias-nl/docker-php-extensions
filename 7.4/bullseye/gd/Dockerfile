FROM php:7.4-bullseye as builder

WORKDIR /extension

COPY ./version ./

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libfreetype6 \
    libpng16-16=1.6.37-3 \
    libjpeg62-turbo=1:2.0.6-4 \
    libfreetype6-dev \
    libpng-dev=1.6.37-3 \
    libwebp-dev \
    libjpeg62-turbo-dev=1:2.0.6-4 && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd \
    --with-freetype=/usr \
    --with-jpeg=/usr \
    --with-webp=/usr

RUN docker-php-ext-install gd && \
     cp "$(php -r "echo ini_get ('extension_dir');")/gd.so" ./

COPY ./install* ./

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
