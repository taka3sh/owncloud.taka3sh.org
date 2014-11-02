#!/bin/sh
chown www-data:www-data /var/www/html/owncloud/config
exec apache2ctl -D FOREGROUND
