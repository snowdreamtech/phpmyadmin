#!/bin/sh
set -e

PHPMYADMIN_CONFIG_PATH=/usr/share/webapps/phpmyadmin/config.inc.php

# Modifying configuration file config.inc.php
# https://github.com/phpmyadmin/docker/blob/master/config.inc.php
if [ "$PMA_ARBITRARY" -eq 1 ]; then
    sed -i "/\$cfg['AllowArbitraryServer']\s*=\s*.+/d" ${PHP_CONFIG_PATH}
    echo "\$cfg['AllowArbitraryServer'] = true;" >>${PHP_CONFIG_PATH}
else
    sed -i "/\$cfg['AllowArbitraryServer']\s*=\s*.+/d" ${PHP_CONFIG_PATH}
fi

# exec commands
exec "$@"
