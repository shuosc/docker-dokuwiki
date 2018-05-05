FROM shuosc/php

LABEL maintainer "zhonger <zhonger@live.cn>"


COPY dokuwiki /etc/nginx/sites-available/default
RUN mkdir -p /run/php

#安装supervisor
RUN apt-get install -y supervisor
COPY dokuwiki.conf /etc/supervisor/conf.d/

CMD ["supervisord","-c","/etc/supervisor/conf.d/dokuwiki.conf"]