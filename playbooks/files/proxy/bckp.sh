#!/bin/bash

DIR='/var/bckp'
DATE=`date +"%Y-%m-%d-%H-%M"`

tar -cvf $DIR/proxy-$DATE.tar.gz /etc/nginx

scp $DIR/proxy-$DATE.tar.gz root@192.168.10.204:/var/backup/proxy/