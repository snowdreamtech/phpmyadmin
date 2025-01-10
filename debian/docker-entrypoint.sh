#!/bin/sh
set -e

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

# BLOWFISH_SECRET  
BLOWFISH_SECRET=$(openssl rand -hex 16)
sed -i "s/\$cfg\['blowfish_secret'\] = '';/\$cfg['blowfish_secret'] = '${BLOWFISH_SECRET}';/g" ${PHPMYADMIN_CONFIG_PATH}

# Storage database and tables  
sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['pmadb'\] = 'phpmyadmin';/\$cfg['Servers'][\$i]['pmadb'] = 'phpmyadmin';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['bookmarktable'\] = 'pma__bookmark';/\$cfg['Servers'][\$i]['bookmarktable'] = 'pma__bookmark';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['relation'\] = 'pma__relation';/\$cfg['Servers'][\$i]['relation'] = 'pma__relation';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['table_info'\] = 'pma__table_info';/\$cfg['Servers'][\$i]['table_info'] = 'pma__table_info';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['table_coords'\] = 'pma__table_coords';/\$cfg['Servers'][\$i]['table_coords'] = 'pma__table_coords';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['pdf_pages'\] = 'pma__pdf_pages';/\$cfg['Servers'][\$i]['pdf_pages'] = 'pma__pdf_pages';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['column_info'\] = 'pma__column_info';/\$cfg['Servers'][\$i]['column_info'] = 'pma__column_info';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['history'\] = 'pma__history';/\$cfg['Servers'][\$i]['history'] = 'pma__history';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['table_uiprefs'\] = 'pma__table_uiprefs';/\$cfg['Servers'][\$i]['table_uiprefs'] = 'pma__table_uiprefs';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['tracking'\] = 'pma__tracking';/\$cfg['Servers'][\$i]['tracking'] = 'pma__tracking';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['userconfig'\] = 'pma__userconfig';/\$cfg['Servers'][\$i]['userconfig'] = 'pma__userconfig';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['recent'\] = 'pma__recent';/\$cfg['Servers'][\$i]['recent'] = 'pma__recent';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['favorite'\] = 'pma__favorite';/\$cfg['Servers'][\$i]['favorite'] = 'pma__favorite';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['users'\] = 'pma__users';/\$cfg['Servers'][\$i]['users'] = 'pma__users';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['usergroups'\] = 'pma__usergroups';/\$cfg['Servers'][\$i]['usergroups'] = 'pma__usergroups';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['navigationhiding'\] = 'pma__navigationhiding';/\$cfg['Servers'][\$i]['navigationhiding'] = 'pma__navigationhiding';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['savedsearches'\] = 'pma__savedsearches';/\$cfg['Servers'][\$i]['savedsearches'] = 'pma__savedsearches';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['central_columns'\] = 'pma__central_columns';/\$cfg['Servers'][\$i]['central_columns'] = 'pma__central_columns';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['designer_settings'\] = 'pma__designer_settings';/\$cfg['Servers'][\$i]['designer_settings'] = 'pma__designer_settings';/g" ${PHPMYADMIN_CONFIG_PATH}

sed -i "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['export_templates'\] = 'pma__export_templates';/\$cfg['Servers'][\$i]['export_templates'] = 'pma__export_templates';/g" ${PHPMYADMIN_CONFIG_PATH}

# start nginx
/usr/sbin/nginx -c /etc/nginx/nginx.conf

#fpm
/usr/bin/php-fpm --fpm-config /etc/php/8.2/fpm/php-fpm.conf

# exec commands
if [ -n "$*" ]; then
    sh -c "$*"
fi

# keep the docker container running
# https://github.com/docker/compose/issues/1926#issuecomment-422351028
if [ "${KEEPALIVE}" -eq 1 ]; then
    trap : TERM INT
    tail -f /dev/null & wait
    # sleep infinity & wait
fi