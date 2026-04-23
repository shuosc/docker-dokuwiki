#!/bin/bash

if [ $DIR ]; then
  echo "Exist DIR environment variable."
  DIR_HOME=/var/www/html/$DIR
  tee /var/www/html/.htaccess << EOF
RewriteEngine on
RewriteCond %{REQUEST_URI} ^/$
RewriteRule (.*) /$DIR/ [R=302]
EOF
else
  echo "No DIR environment variable."
  DIR_HOME=/var/www/html
  
  rm -rf /var/www/html
fi

DIR_DATA=$DIR_HOME/data
DIR_CONF=$DIR_HOME/conf
DIR_LIB=$DIR_HOME/lib

cp -R /opt/dokuwiki $DIR_HOME

if [ "`ls -A /opt/data/conf`" = "" ]; then
  echo "Dokuwiki aren't installed."
  echo "Start the installation ......"
  mkdir -p /opt/data/data /opt/data/conf /opt/data/lib
  cp -R /opt/dokuwiki/conf/* /opt/data/conf/
  cp -R /opt/conf/* /opt/data/conf/
  cp -R /opt/dokuwiki/data/* /opt/data/data/
  cp -R /opt/dokuwiki/lib/images /opt/data/lib/images
  cp -R /opt/dokuwiki/lib/plugins /opt/data/lib/plugins
  cp -R /opt/dokuwiki/lib/tpl /opt/data/lib/tpl
else
  echo "Dokuwiki has been installed."
fi

rm -rf $DIR_HOME/install.php \
       $DIR_DATA $DIR_CONF \
       $DIR_LIB/images $DIR_LIB/plugins $DIR_LIB/tpl
ln -s /opt/data/conf $DIR_CONF
ln -s /opt/data/data $DIR_DATA
ln -s /opt/data/lib/images $DIR_LIB/images
ln -s /opt/data/lib/plugins $DIR_LIB/plugins
ln -s /opt/data/lib/tpl $DIR_LIB/tpl

chown -R www-data:www-data /var/www/html
chown -R www-data:www-data /opt/data

echo "The dokuwiki site is live."

apache2-foreground
