FROM dtools/dev:base-buster

LABEL maintainer="Sebastian Heinlein <sebastian.heinlein@dpool.com>"

ENV PHP_VERSION 	"7.4"
ENV COMPOSER_VERSION 	"1.10.8"

ENV DISABLE_MODULES 	"mpm_prefork"
ENV ENABLE_MODULES 	"alias autoindex expires headers http2 mpm_worker proxy proxy_fcgi rewrite ssl"
ENV ENABLE_CONFS 	"dpool php$PHP_VERSION-fpm"

# PHP backport
RUN \
	wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
	sh -c 'echo "deb https://packages.sury.org/php/ buster main" > /etc/apt/sources.list.d/php.list'

RUN apt-get update && apt-get install -q -y \
	apache2 \
	geoip-database \
	ghostscript \
	graphicsmagick \
	imagemagick \
	npm \
	php-geoip \
	php-pear \
	php-xdebug \
	php-yaml \
	php${PHP_VERSION}-bz2 \
	php${PHP_VERSION}-cli \
	php${PHP_VERSION}-curl \
	php${PHP_VERSION}-fpm \
	php${PHP_VERSION}-gd \
	php${PHP_VERSION}-intl \
	php${PHP_VERSION}-json \
	php${PHP_VERSION}-ldap \
	php${PHP_VERSION}-mbstring \
	php${PHP_VERSION}-mysql \
	php${PHP_VERSION}-opcache \
	php${PHP_VERSION}-soap \
	php${PHP_VERSION}-xml \
	php${PHP_VERSION}-xmlrpc \
	php${PHP_VERSION}-xsl \
	php${PHP_VERSION}-zip \
	poppler-util

COPY files/supervisord-apache2.conf /etc/supervisor/conf.d/apache2.conf
COPY files/supervisord-php-fpm.conf /etc/supervisor/conf.d/php-fpm.conf

# TODO
#COPY files/healthcheck-php-fpm.sh /usr/local/lib/healthcheck/php-fpm.sh
#COPY files/healthcheck-apache2.sh /usr/local/lib/healthcheck/apache2.sh

# Setup php
RUN \
	mkdir -p /var/run/php && \
	mkdir -p /usr/local/share/php
COPY files/opcache.php /usr/local/share/php
COPY files/phpinfo.php /usr/local/share/php
COPY files/php.ini /etc/php/${PHP_VERSION}/fpm/conf.d/ZZ_dpool.ini
COPY files/php.ini /etc/php/${PHP_VERSION}/cli/conf.d/ZZ_dpool.ini

# Install composer
RUN \
	curl -o /usr/local/bin/composer https://getcomposer.org/download/${COMPOSER_VERSION}/composer.phar && \
	chmod a+x /usr/local/bin/composer

# Setup apache
COPY files/apache2.conf /etc/apache2/conf-available/dpool.conf
COPY files/default-site.conf /etc/apache2/sites-available/000-default.conf
RUN \
	mkdir -p /var/run/apache2 && \
	for MOD in $DISABLE_MODULES; do a2dismod $MOD; done && \
	for MOD in $ENABLE_MODULES; do a2enmod $MOD; done && \
	for CONF in $ENABLE_CONFS; do a2enconf $CONF; done

copy files/docker-entrypoint-www-data.sh /usr/local/lib/docker-entrypoint/www-data.sh

WORKDIR /var/www

EXPOSE 22 80 443 9000
