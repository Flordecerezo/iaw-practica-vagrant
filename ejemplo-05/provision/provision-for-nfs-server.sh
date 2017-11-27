#!/bin/bash

source /vagrant/provision/provision-for-apache.sh

IP_NFS_CLIENT=192.168.33.12

apt-get install -y nfs-kernel-server
chown nobody:nogroup /var/www/html
echo "/var/www/html      ${IP_NFS_CLIENT}(rw,sync,no_root_squash,no_subtree_check)" >> /etc/exports
/etc/init.d/nfs-kernel-server restart