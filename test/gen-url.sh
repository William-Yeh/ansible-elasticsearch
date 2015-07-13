#!/bin/sh
#
# generate url for testing within Docker container.
#

IP=`head -n 1 /etc/hosts | awk '{ print $1 }'`

echo http://$IP:9200/
