FROM php:7.2-fpm

MAINTAINER Florentin Garnier <florentin@digital404.fr>

RUN apt-get update && apt-get install -y \
    libicu-dev \
    libzip-dev \
    && apt-get clean

RUN docker-php-ext-install -j$(nproc) pdo_mysql opcache pcntl intl zip

COPY php.ini /usr/local/etc/php/conf.d/

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

WORKDIR /srv