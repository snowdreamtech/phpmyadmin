#!/bin/sh
set -e

PHPMYADMIN_CONFIG_PATH=/usr/share/webapps/phpmyadmin/config.inc.php

# Modifying configuration file config.inc.php
# https://github.com/phpmyadmin/docker/blob/master/config.inc.php
if [ "$PMA_ARBITRARY" -eq 1 ]; then
    sed -i "/\$cfg['AllowArbitraryServer']\s*=\s*.+/d" ${PHPMYADMIN_CONFIG_PATH}
    echo "\$cfg['AllowArbitraryServer'] = true;" >>${PHPMYADMIN_CONFIG_PATH}
else
    sed -i "/\$cfg['AllowArbitraryServer']\s*=\s*.+/d" ${PHPMYADMIN_CONFIG_PATH}
fi

if [ -n "${PMA_AUTH_TYPE}" ]; then
    sed -i "/\$cfg\['Servers'\]\[\$i\]\['auth_type'\]/d" ${PHPMYADMIN_CONFIG_PATH}
    echo "\$cfg['Servers'][\$i]['auth_type'] = '${PMA_AUTH_TYPE}';" >>${PHPMYADMIN_CONFIG_PATH}
fi

if [ -n "${PMA_HOST}" ]; then
    sed -i "/\$cfg\['Servers'\]\[\$i\]\['host'\]/d" ${PHPMYADMIN_CONFIG_PATH}
    echo "\$cfg['Servers'][\$i]['host'] = '${PMA_HOST}';" >>${PHPMYADMIN_CONFIG_PATH}
fi

if [ -n "${PMA_VERBOSE}" ]; then
    sed -i "/\$cfg\['Servers'\]\[\$i\]\['verbose'\]/d" ${PHPMYADMIN_CONFIG_PATH}
    echo "\$cfg['Servers'][\$i]['verbose'] = '${PMA_VERBOSE}';" >>${PHPMYADMIN_CONFIG_PATH}
fi

if [ -n "${PMA_PORT}" ]; then
    sed -i "/\$cfg\['Servers'\]\[\$i\]\['port'\]/d" ${PHPMYADMIN_CONFIG_PATH}
    echo "\$cfg['Servers'][\$i]['port'] = ${PMA_PORT};" >>${PHPMYADMIN_CONFIG_PATH}
fi

if [ -n "${PMA_USER}" ]; then
    sed -i "/\$cfg\['Servers'\]\[\$i\]\['user'\]/d" ${PHPMYADMIN_CONFIG_PATH}
    echo "\$cfg['Servers'][\$i]['user'] = '${PMA_USER}';" >>${PHPMYADMIN_CONFIG_PATH}
fi

if [ -n "${PMA_PASS}" ]; then
    sed -i "/\$cfg\['Servers'\]\[\$i\]\['password'\]/d" ${PHPMYADMIN_CONFIG_PATH}
    echo "\$cfg['Servers'][\$i]['password'] = '${PMA_PASS}';" >>${PHPMYADMIN_CONFIG_PATH}
fi

# exec commands
exec "$@"
