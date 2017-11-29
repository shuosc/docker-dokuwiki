FROM ubuntu:latest

MAINTAINER zhonger <zhonger@live.cn>

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY ./ubuntu/sources.list /etc/apt/sources.list
RUN apt-get update

#设置时区
RUN echo y | apt-get install tzdata
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

#安装vim及升级
RUN echo y | apt-get install apt-utils vim language-pack-zh-hans
RUN echo y | apt-get upgrade

#安装nginx
RUN echo y | apt-get install nginx
EXPOSE 80
VOLUME [ "/var/www/html" ]

#安装php7和dokuwiki
RUN echo y | apt-get install php7.0-cli php7.0-common php7.0-curl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-opcache php7.0-readline php7.0-xml php7.0-zip php7.0-sqlite3 php7.0-mysql php7.0-pgsql
RUN echo y | apt-get install php7.0 php7.0-fpm 
COPY ./dokuwiki/dokuwiki /etc/nginx/sites-available/default
RUN mkdir -p /run/php

#安装supervisor
RUN echo y |apt-get install supervisor
COPY dokuwiki.conf /etc/supervisor/conf.d/

CMD ["supervisord","-c","/etc/supervisor/conf.d/dokuwiki.conf"]