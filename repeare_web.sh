#!/bin/bash

bckp_name=`ssh root@192.168.10.204 ls -t /var/backup/web/ | head -1 `

echo "$bckp_name"

scp root@192.168.10.204:/var/backup/web/"$bckp_name" /tmp/ 

tar -C "/tmp" -xvf /tmp/"$bckp_name"

mv /tmp/var/bckp/"${bckp_name%???????}"/wordpress.sql /tmp
mv /tmp/var/bckp/"${bckp_name%???????}"/html /tmp/

scp -r /tmp/html/ root@192.168.10.201:/var/www/
scp -r /tmp/wordpress.sql root@192.168.10.201:/tmp
ssh -n root@192.168.10.201 'chown -R apache:apache /var/www/html'

ssh -n root@192.168.10.201 'mysql -uroot -p1q@W3e4r -e "drop database wordpress"'
ssh -n root@192.168.10.201 'mysql -uroot -p1q@W3e4r -e "create database wordpress"'
ssh -n root@192.168.10.201 'mysql -uroot -p1q@W3e4r wordpress < /tmp/wordpress.sql'

rm -rf /tmp/"$bckp_name" /tmp/wordpress.sql /tmp/html /tmp/var