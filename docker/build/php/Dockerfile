ARG PHP_VERSION=8.4
ARG UID=1000
ARG TARGET=base

#################################################################


FROM php:${PHP_VERSION}-fpm AS base
ARG PHP_VERSION=8.4
ARG UID=1000
ARG TARGET=base

RUN adduser -u ${UID} --disabled-password --gecos "" appuser
RUN mkdir /home/appuser/.ssh
RUN chown -R appuser:appuser /home/appuser/
RUN echo "StrictHostKeyChecking no" >> /home/appuser/.ssh/config
RUN echo "alias ll='ls -lah'" >> /home/appuser/.bashrc \
    && echo "alias sf='php /var/www/app/bin/console'" >> /home/appuser/.bashrc

COPY php.ini /usr/local/etc/php/php.ini
COPY php-fpm.conf /usr/local/etc/php-fpm.conf

RUN apt-get update \
    && apt-get install -y acl zip vim nano curl librabbitmq-dev libssh-dev \
    libxml2-dev libicu-dev libcurl4-openssl-dev gettext \
    zlib1g-dev libpng-dev libzip-dev libjpeg-dev libfreetype6-dev procps \
    && pecl install amqp \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install intl pdo pdo_mysql zip soap bcmath sockets opcache mysqli curl fileinfo gd ftp \
    && docker-php-ext-enable opcache amqp \
    && mkdir -p /var/www/app \
    && chmod 644 /usr/local/etc/php/php.ini \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer



###############################################################################


FROM base AS dev
ARG PHP_VERSION=8.4
ARG UID=1000
ARG TARGET=dev

RUN pecl install xdebug && docker-php-ext-enable xdebug
#COPY xdebug.ini.template /usr/local/etc/php/templates/php-ext-xdebug.template
EXPOSE 9003


###############################################################################


FROM ${TARGET}

ARG PHP_VERSION=8.4
ARG UID=1000
ARG TARGET=base

#COPY entrypoint.sh /docker-entrypoint.sh

ENV TZ=Europe/Madrid
ENV VERSION=${PHP_VERSION}
ENV WORKDIR=/var/www/app
ENV SERVER_ALIAS=micro_php

RUN echo 'if [ "$(id -u)" = "0" ] && [ -n "$PS1" ]; then exec su - appuser; fi' >> /root/.bashrc

WORKDIR /var/www/app

EXPOSE 9000

#ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
