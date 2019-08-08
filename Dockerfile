FROM php:7.2-fpm

LABEL maintainer="Linc <qulamj@gmail.com>"

# Set Environment Variables
ENV DEBIAN_FRONTEND noninteractive

USER root

#
#--------------------------------------------------------------------------
# Software's Installation
#--------------------------------------------------------------------------
#
# Installing tools and PHP extentions using "apt", "docker-php", "pecl",
#

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    apt-utils \
    vim \
    curl \
    supervisor \
    libpq-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libssl-dev \
    libmcrypt-dev \
    libzip-dev && \
    # Install the PHP Core Extensions
    docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd exif zip && \
    # Install the PHP Swoole and Xdebug library
    pecl install swoole xdebug && \
    docker-php-ext-enable swoole xdebug && \
    # Install the Comopser
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --quiet --install-dir=/usr/bin --filename=composer && \
    rm composer-setup.php

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog