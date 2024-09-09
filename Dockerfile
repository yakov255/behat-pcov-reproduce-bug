# syntax = docker/dockerfile:1.4.0

FROM php:8.2-bullseye

# Surpresses debconf complaints of trying to install apt packages interactively
# https://github.com/moby/moby/issues/4032#issuecomment-192327844
ARG DEBIAN_FRONTEND=noninteractive

# Install xdebug
RUN pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    mkdir /var/log/xdebug

## composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
RUN mkdir /var/www/.composer/ && chown www-data:www-data /var/www/.composer/

## git
RUN set -x && apt-get update  \
    && apt-get install -y  \
    git \
    && rm -rf /var/lib/apt/lists/*

# pcov
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    && pecl install pcov \
    && docker-php-ext-enable pcov \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure xdebug
RUN <<INI cat >> /usr/local/etc/php/conf.d/xdebug.ini
    xdebug.mode=debug,develop
    xdebug.discover_client_host=yes
    xdebug.client_port=9000
    xdebug.client_host=host.docker.internal
INI
