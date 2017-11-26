#!/bin/bash
# Retrieve new lists of packages
apt-get update

# Install Apache and PHP packages
apt-get install -y apache2
apt-get install -y php libapache2-mod-php php-mysql
/etc/init.d/apache2 restart

# Install Adminer
cd /var/www/html
wget https://github.com/vrana/adminer/releases/download/v4.3.1/adminer-4.3.1-mysql.php
mv adminer-4.3.1-mysql.php adminer.php

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
DB_HOST=192.168.33.13
sed -i -e "s/database_name_here/$DB_WP_NAME/" wp-config.php
sed -i -e "s/username_here/$DB_WP_USER/" wp-config.php
sed -i -e "s/password_here/$DB_WP_PASSWORD/" wp-config.php
sed -i -e "s/localhost/$DB_HOST/" wp-config.php

# Configure WP_HOME and WP_SITEURL
echo "define('WP_HOME','http://192.168.33.10/wordpress');" >> wp-config.php
echo "define('WP_SITEURL','http://192.168.33.10');" >> wp-config.php

# Configure the security keys
curl https://api.wordpress.org/secret-key/1.1/salt/ >> wp-config.php

# Create uploads directory
cd /var/www/html
mkdir -p wordpress/wp-content/uploads
chown -R www-data:www-data *

# Configure Wordpress to rewrite wordpress subdirectory with permalinks
rm -f index.html
cp wordpress/index.php .
sed -i -e "s/wp-blog-header.php/wordpress\/wp-blog-header.php/" index.php
cp /vagrant/htaccess .htaccess