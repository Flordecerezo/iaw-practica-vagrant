#!/bin/bash
# Retrieve new lists of packages
apt-get update

# Install nginx
apt-get install -y nginx

# Install php packages for nginx
apt-get install -y php-fpm php-mysql php-curl php-gd php-mbstring php-mcrypt php-xml php-xmlrpc

# Configure php for nginx
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini
systemctl restart php7.0-fpm

# Copy configuration file for nginx
cp /vagrant/config/nginx.default /etc/nginx/sites-available/default
systemctl reload nginx

# Check the installation
cp /vagrant/test-php/info.php /var/www/html

# Install tools
apt-get install -y unzip

# Download and unzip Wordpress
cd /var/www/html
rm -f latest.zip
wget https://wordpress.org/latest.zip
unzip -o latest.zip

# Configure Wordpress to connect with MySQL
cd wordpress
cp wp-config-sample.php wp-config.php

DB_WP_NAME=wordpress
DB_WP_USER=wp_user;
DB_WP_PASSWORD=wp_password;
DB_HOST=192.168.33.10
sed -i -e "s/database_name_here/$DB_WP_NAME/" wp-config.php
sed -i -e "s/username_here/$DB_WP_USER/" wp-config.php
sed -i -e "s/password_here/$DB_WP_PASSWORD/" wp-config.php
sed -i -e "s/localhost/$DB_HOST/" wp-config.php

# Configure WP_HOME and WP_SITEURL
#
# WP_HOME refer to the "Site Address (URL)"
# or what you want regular visitors to type in their browser.
# WP_SITEURL refer to the "WordPress Address (URL)"
# or the address where your WordPress core files reside.

WP_HOME="define('WP_HOME','http://192.168.33.10');"
WP_SITEURL="define('WP_SITEURL','http://192.168.33.10/wordpress');"

sed -i "/<?php/a $WP_SITEURL" wp-config.php
sed -i "/<?php/a $WP_HOME" wp-config.php

# Remove the lines related with the security keys
sed -i "/put your unique phrase here/d" wp-config.php

# Add new values for the security keys.
# Replace / by _ in order to avoid confusion with the delimiter char /
SECRET_KEYS=`curl https://api.wordpress.org/secret-key/1.1/salt/`
SECRET_KEYS=`echo $SECRET_KEYS | tr / _`
sed -i "/#@-/a $SECRET_KEYS" wp-config.php

# Create uploads directory
cd /var/www/html
mkdir -p wordpress/wp-content/uploads
chown -R www-data:www-data *

# Configure Wordpress to rewrite wordpress subdirectory with permalinks
rm -f index.html
cp wordpress/index.php .
sed -i -e "s/wp-blog-header.php/wordpress\/wp-blog-header.php/" index.php