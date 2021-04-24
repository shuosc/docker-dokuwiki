FROM shuosc/nginx

LABEL maintainer "zhonger <zhonger@live.cn>"

RUN apt-get install -y php7.4-cli php7.4-common php7.4-curl php7.4-json php7.4-mbstring php7.4-mcrypt php7.4-opcache php7.4-readline php7.4-xml php7.4-zip php7.4-sqlite3 php7.4-mysql php7.4-pgsql
RUN apt-get install -y php7.4 php7.4-fpm 
COPY default /etc/nginx/sites-available/default
RUN mkdir -p /run/php

COPY start.sh /root

WORKDIR /root

CMD ["/bin/bash","/root/start.sh"]