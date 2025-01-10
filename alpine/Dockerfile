FROM snowdreamtech/php:8.4.2-fpm-alpine3.21

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="phpMyAdmin Image Based On Alpine" \
    org.opencontainers.image.description="Docker Images for phpMyAdmin on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le,riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/phpmyadmin" \
    org.opencontainers.image.base.name="snowdreamtech/phpmyadmin:alpine" \
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
    PHPMYADMIN_CONFIG_PATH=/var/lib/nginx/html/config.inc.php

ARG GID=1000 \
    UID=1000  \
    USER=root \
    WORKDIR=/root

# Create a user with UID and GID
RUN if [ "${USER}" != "root" ]; then \
    addgroup -g ${GID} ${USER}; \
    adduser -h /home/${USER} -u ${UID} -g ${USER} -G ${USER} -s /bin/sh -D ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi

# Enable CAP_NET_BIND_SERVICE
RUN if [ "${USER}" != "root" ] && [ "${CAP_NET_BIND_SERVICE}" -eq 1 ]; then \
    apk add --no-cache libcap; \
    # setcap 'cap_net_bind_service=+ep' `which nginx`; \
    fi

RUN wget https://files.phpmyadmin.net/phpMyAdmin/${PMA_VERSION}/phpMyAdmin-${PMA_VERSION}-all-languages.zip \
    && unzip phpMyAdmin-${PMA_VERSION}-all-languages.zip \
    && mv phpMyAdmin-${PMA_VERSION}-all-languages/* /var/lib/nginx/html \
    && cp /var/lib/nginx/html/config.sample.inc.php /var/lib/nginx/html/config.inc.php \
    && chown -Rv nginx:nginx /var/lib/nginx/html \
    && rm -rfv phpMyAdmin-${PMA_VERSION}-all-languages \
    && rm -rfv phpMyAdmin-${PMA_VERSION}-all-languages.zip 

# Switch to the user
USER nginx

# Set the workdir
WORKDIR /var/lib/nginx/html

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]