FROM php:7.2-fpm

MAINTAINER Florentin Garnier <florentin@digital404.fr>

RUN apt-get update && apt-get install -y \
    libicu-dev \
    libzip-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    && apt-get clean

RUN docker-php-ext-install -j$(nproc) pdo_mysql opcache pcntl intl zip exif\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install apcu xdebug
RUN docker-php-ext-enable apcu xdebug

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

WORKDIR /srv