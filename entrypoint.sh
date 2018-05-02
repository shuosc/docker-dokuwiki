#!/bin/bash
DIR_HOME=/var/www/html/$DIR
DIR_DATA=/var/www/html/$DIR/data
DIR_CONF=/var/www/html/$DIR/conf
DIR_LIB=/var/www/html/$DIR/lib

#mkdir -p $DIR_HOME /opt/data/data /opt/data/conf /opt/data/lib
#cp -R /opt/dokuwiki $DIR_HOME

if [ "`ls -A /opt/data/conf/local.php`" = "" ]; then
  echo "Data directory is indeed empty"
  cp -R /opt/dokuwiki/data /opt/data/data
  cp -R /opt/dokuwiki/conf /opt/data/conf
  cp -R /opt/conf/* /opt/data/conf
  mkdir -p /opt/data/lib
  cp -R /opt/dokuwiki/lib/images /opt/data/lib/images
  cp -R /opt/dokuwiki/lib/plugins /opt/data/lib/plugins
  cp -R /opt/dokuwiki/lib/tpl /opt/data/lib/tpl
  
  #cp /opt/conf/local.php $DIR_CONF
  #cp /opt/conf/acl.auth.php $DIR_CONF
  #cp /opt/conf/users.auth.php $DIR_CONF
else
  echo "Data directory is not empty"
fi

chown -R www-data:www-data /var/www/html
chown -R www-data:www-data /opt/data

sed -i "s/\$DIR/$DIR/" /etc/nginx/sites-enabled/default
sed -i "s/\$DIR/$DIR/" /etc/nginx/sites-enabled/default

echo "The dokuwiki site is live."

supervisord -c /etc/supervisor/conf.d/dokuwiki.conf
