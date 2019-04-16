#!/bin/bash
/usr/sbin/sshd -D &
chown www-data:www-data /app -R
source /etc/apache2/envvars
exec apache2 -D FOREGROUND
