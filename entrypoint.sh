#!/bin/bash

if [ $DIR ]; then
  echo "Exist DIR environment variable."
  DIR_HOME=/var/www/html/$DIR
  DIR_DATA=/var/www/html/$DIR/data
  DIR_CONF=/var/www/html/$DIR/conf
  DIR_LIB=/var/www/html/$DIR/lib
  tee /var/www/html/.htaccess << EOF
RewriteEngine on
RewriteCond %{REQUEST_URI} ^/$
RewriteRule (.*) /$DIR/ [R=302]
EOF
else
  echo "No DIR environment variable."
  DIR_HOME=/var/www/html
  DIR_DATA=/var/www/html/data
  DIR_CONF=/var/www/html/conf
  DIR_LIB=/var/www/html/lib
  rm -rf /var/www/html
fi

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
fi

rm -rf $DIR_HOME/install.php $DIR_DATA $DIR_CONF $DIR_LIB/images $DIR/plugins $DIR/tpl 
ln -s /opt/data/conf $DIR_CONF
ln -s /opt/data/data $DIR_DATA
ln -s /opt/data/lib/images $DIR_LIB/images
ln -s /opt/data/lib/plugins $DIR_LIB/plugins
ln -s /opt/data/lib/tpl $DIR_LIB/tpl

echo "Dokuwiki has been installed."

chown -R www-data:www-data /var/www/html
chown -R www-data:www-data /opt/data
chown -R www-data:www-data /opt/conf

echo "The dokuwiki site is live."

apache2-foreground
