#!/bin/bash

DIR='/var/bckp'
DATE=`date +"%Y-%m-%d-%H-%M"`
mkdir $DIR/web-$DATE
cp -r /etc/http $DIR/web-$DATE
cp -r /var/www/html $DIR/web-$DATE

mysqldump -uroot -p1q@W3e4r wordpress > $DIR/web-$DATE/wordpress.sql

tar -cvf $DIR/web-$DATE.tar.gz $DIR/web-$DATE

scp $DIR/proxy-$DATE.tar.gz root@192.168.10.204:/var/backup/proxy/