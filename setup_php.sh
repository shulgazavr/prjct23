#!/bin/bash

yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y install yum-utils
yum-config-manager --disable remi-php54
yum-config-manager --enable remi-php73
yum -y install php php-common php-mysql php-gd php-xml php-mbstring php-mcrypt
systemctl restart httpd.service