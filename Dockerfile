FROM php:7.4-fpm

MAINTAINER Florentin Garnier <florentin@digital404.fr>

RUN apt-get update && apt-get install -y \
    libicu-dev \
    libzip-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    unzip \
    && apt-get clean

RUN docker-php-ext-install -j$(nproc) pdo_mysql opcache pcntl intl zip exif\
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install apcu xdebug
RUN docker-php-ext-enable apcu xdebug

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

WORKDIR /srv
