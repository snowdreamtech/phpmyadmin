FROM snowdreamtech/php:8.2.26-fpm-bookworm

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="phpMyAdmin Image Based On Debian" \
    org.opencontainers.image.description="Docker Images for phpMyAdmin on Debian. (i386,amd64,arm32v5,arm32v7,arm64,mips64le,ppc64le,s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/phpmyadmin" \
    org.opencontainers.image.base.name="snowdreamtech/phpmyadmin:debian" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/phpmyadmin" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="5.2.1" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/phpmyadmin"

# Switch to the user
USER root

# Set the workdir
WORKDIR /root

# keep the docker container running
ENV KEEPALIVE=1 \
    # The cap_net_bind_service capability in Linux allows a process to bind a socket to Internet domain privileged ports, 
    # which are port numbers less than 1024. 
    CAP_NET_BIND_SERVICE=0

ENV PMA_VERSION="5.2.1" \
    PMA_ARBITRARY=0 \
    PMA_AUTH_TYPE="cookie" \
    PMA_HOST="localhost" \
    PMA_VERBOSE="localhost" \
    PMA_PORT=3306 \
    PMA_USER="root" \
    PMA_PASS="" \
    PHPMYADMIN_CONFIG_PATH=/usr/share/nginx/html/config.inc.php

ARG GID=1000 \
    UID=1000  \
    USER=root \
    WORKDIR=/root

# Create a user with UID and GID
RUN set -eux \
    && if [ "${USER}" != "root" ]; then \
    addgroup --gid ${GID} ${USER}; \
    adduser --home /home/${USER} --uid ${UID} --gid ${GID} --gecos ${USER} --shell /bin/bash --disabled-password ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy --purge autoremove \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* 

# Enable CAP_NET_BIND_SERVICE
RUN set -eux \
    && if [ "${USER}" != "root" ] && [ "${CAP_NET_BIND_SERVICE}" -eq 1 ]; then \
    DEBIAN_FRONTEND=noninteractive apt-get -qqy update; \
    DEBIAN_FRONTEND=noninteractive apt-get -qqy install --no-install-recommends libcap2-bin; \
    # setcap 'cap_net_bind_service=+ep' `which nginx`; \
    fi \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy --purge autoremove \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* 

RUN set -eux \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy update  \
    && wget https://files.phpmyadmin.net/phpMyAdmin/${PMA_VERSION}/phpMyAdmin-${PMA_VERSION}-all-languages.zip \
    && unzip phpMyAdmin-${PMA_VERSION}-all-languages.zip \
    && mv phpMyAdmin-${PMA_VERSION}-all-languages/* /usr/share/nginx/html \
    && cp /usr/share/nginx/html/config.sample.inc.php /usr/share/nginx/html/config.inc.php \
    && chown -Rv nginx:nginx /usr/share/nginx/html \
    && rm -rfv phpMyAdmin-${PMA_VERSION}-all-languages \
    && rm -rfv phpMyAdmin-${PMA_VERSION}-all-languages.zip \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy --purge autoremove \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Switch to the user
USER nginx

# Set the workdir
WORKDIR /usr/share/nginx/html

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]