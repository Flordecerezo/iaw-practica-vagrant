#!/bin/bash
# Retrieve new lists of packages
apt-get update

# Install nginx
apt-get install -y nginx

# Copy configuration file for nginx
cp /vagrant/config/nginx.balancer /etc/nginx/sites-available/default
systemctl reload nginx