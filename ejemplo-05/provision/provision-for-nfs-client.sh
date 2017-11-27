#!/bin/bash

source /vagrant/provision/provision-for-apache.sh

IP_NFS_SERVER=192.168.33.11

apt-get update
apt-get install -y nfs-common
mount ${IP_NFS_SERVER}:/var/www/html /var/www/html
echo "${IP_NSF_SERVER}:/var/www/html /var/www/html  nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" >> /etc/fstab
