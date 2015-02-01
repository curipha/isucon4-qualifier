#!/usr/bin/env bash

set -u
set -x

UNICORNPID=`ps aux | grep -E '[u]nicorn master' | awk '{ print $2 }'`


sudo service nginx stop
sudo kill -USR2 ${UNICORNPID}

sudo rm -rf /var/log/nginx/*

sudo service nginx start
sudo service mysql restart

sleep 2
sudo kill -WINCH ${UNICORNPID}
sleep 2
sudo kill -QUIT ${UNICORNPID}

