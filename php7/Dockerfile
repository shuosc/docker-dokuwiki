FROM shuosc/nginx

MAINTAINER zhonger <zhonger@live.cn>

RUN echo y | apt-get install php7.0-cli php7.0-common php7.0-curl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-opcache php7.0-readline php7.0-xml php7.0-zip php7.0-sqlite3 php7.0-mysql php7.0-pgsql
RUN echo y | apt-get install php7.0 php7.0-fpm 
COPY default /etc/nginx/sites-available/default
RUN mkdir -p /run/php

COPY start.sh /root

WORKDIR /root

CMD ["/bin/bash","/root/start.sh"]