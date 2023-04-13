#!/bin/bash

bckp_name=`ssh root@192.168.10.204 ls -t /var/backup/web/ | head -1`

echo $bckp_name