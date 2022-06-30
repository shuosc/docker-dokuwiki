FROM php:7.4-apache

LABEL maintainer "zhonger <zhonger@live.cn>"

# Environments
ENV VERSION rc

# Install necessary softwares
RUN apt-get update \
    && apt-get install -y wget tar \
    && apt-get upgrade -y

# Install php extensions & Enable rewrite mod
RUN apt-get install libldap-dev -y \
    && && ln -s /usr/lib/i386-linux-gnu/libldap.so /usr/lib/libldap.so \
    && docker-php-ext-install ldap \
    && a2enmod rewrite remoteip\
    && apt-get clean \ 
    && rm -rf /var/lib/apt/lists/*

# Install Dokuwiki
RUN mkdir -p /opt \
    && cd /opt && wget https://download.dokuwiki.org/src/dokuwiki/dokuwiki-$VERSION.tgz \
    && tar zxf dokuwiki-$VERSION.tgz \
    && rm -rf dokuwiki-$VERSION.tgz \
    && mv $(ls | grep dokuwiki-) dokuwiki \
    && chown -R www-data:www-data /opt/dokuwiki

# Reset apache2 log
RUN rm -rf /var/log/apache2/* \
    && touch access.log error.log other_vhosts_access.log \
    && chown -R www-data:www-data /var/log/apache2

ADD ./conf /opt/conf
COPY apache2.conf /etc/apache2/apache2.conf
COPY .htaccess /opt/dokuwiki/.htaccess
COPY entrypoint.sh /entrypoint.sh

VOLUME [ '/opt/data' ]
VOLUME [ '/var/log/apache2' ]
CMD ["/entrypoint.sh"]
