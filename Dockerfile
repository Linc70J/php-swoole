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

# Install "curl", "apt-utils", "vim", "supervisor", "libmemcached-dev", "libpq-dev",
#         "libjpeg-dev", "libpng-dev", "libfreetype6-dev", "libssl-dev", "libmcrypt-dev",
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y --no-install-recommends \
    curl \
    apt-utils \
    vim \
    supervisor \
    libmemcached-dev \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
    libzip-dev zip unzip

# always run apt update when start and after add new source list.
RUN set -xe; \
    # Install the PHP zip library
    pecl channel-update pecl.php.net && \
    docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install zip && \
    # Install the PHP swoole library
    pecl install swoole && \
    docker-php-ext-enable swoole

# composer
RUN mkdir /tmp/composer && \
    cd /tmp/composer; curl -sS https://getcomposer.org/installer | php; cd - && \
    mv /tmp/composer/composer.phar /usr/local/bin/composer

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog