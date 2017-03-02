#!/bin/bash

role=`id -u`
if test $role -ne 0
then
    echo "You install this project which requires root privileges"
    exit 1
fi


cd `dirname $0`

curl https://raw.githubusercontent.com/WALL-E/static/master/setup/redhat/install_openresty|bash

cp -f ./nginx.conf /opt/openresty/nginx/conf
