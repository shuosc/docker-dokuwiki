FROM shuosc/ubuntu:ustc

LABEL maintainer "zhonger <zhonger@live.cn>"

#安装vim及升级
RUN apt-get install -y vim wget tar unzip \
    && apt-get upgrade -y

#安装nginx
RUN apt-get update && apt-get install -y nginx
EXPOSE 80

#安装php7和dokuwiki
RUN apt-get install -y libnss3-tools jq xsel && \
    apt-get install -y php7.4-cli php7.4-common php7.4-curl php7.4-json php7.4-mbstring php7.4-opcache && \
    apt-get install -y php7.4-readline php7.4-xml php7.4-zip php7.4-sqlite3 php7.4-mysql php7.4-pgsql && \
    apt-get install -y php7.4 php7.4-fpm && mkdir -p /var/run/php

#二级目录名称
ENV DIR=wiki

#下载dokuwiki最新源码
RUN mkdir -p /opt /var/www/html/$DIR  && \
	mkdir -p /opt/data/data /opt/data/conf /opt/data/lib && \
    cd /opt && wget https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz && \
    tar zxf dokuwiki-stable.tgz && rm -rf dokuwiki-stable.tgz && \
    mv $(ls | grep dokuwiki-20) dokuwiki && \
    rm -rf /var/www/html/index.nginx-debian.html && \
    chown -R www-data:www-data /opt/dokuwiki && \
    cp -R /opt/dokuwiki/* /var/www/html/$DIR

# 准备挂载目录	
RUN rm -rf /var/www/html/$DIR/data /var/www/html/$DIR/conf /var/www/html/$DIR/lib/images /var/www/html/$DIR/lib/plugins /var/www/html/$DIR/lib/tpl \
    && ln -s /opt/data/data/ /var/www/html/$DIR/data \
    && ln -s /opt/data/conf/ /var/www/html/$DIR/conf \
    && mkdir -p /opt/data/lib/images /opt/data/lib/images /opt/data/lib/tpl \ 
	&& ln -s /opt/data/lib/images /var/www/html/$DIR/lib/images \
    && ln -s /opt/data/lib/plugins /var/www/html/$DIR/lib/plugins \
    && ln -s /opt/data/lib/tpl /var/www/html/$DIR/lib/tpl

#安装supervisor
RUN apt-get install -y supervisor
COPY ./supervisor/dokuwiki.conf /etc/supervisor/conf.d/
ADD ./dokuwiki/conf /opt/conf
COPY ./nginx/default /etc/nginx/sites-available/default
COPY entrypoint.sh /entrypoint.sh

VOLUME [ '/opt/data' ]
CMD ["/entrypoint.sh"]
