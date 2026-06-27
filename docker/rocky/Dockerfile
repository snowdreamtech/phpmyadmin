# Base Image (Rocky Variant)
# Extends snowdreamtech/php with additional tooling and configuration.

FROM snowdreamtech/php:8.4.21-nginx-rocky

# Build-time Configuration
ARG BUILDTIME \
    VERSION \
    REVISION \
    KEEPALIVE=0 \
    CAP_NET_BIND_SERVICE=0 \
    LANG=C.UTF-8 \
    UMASK=022 \
    DEBUG=false \
    PASSWORDLESS_SUDO=false \
    PGID=0 \
    PUID=0 \
    USER=root \
    WORKDIR=/root \
    PHPMYADMIN_PATH=/var/www/html

# x-release-please-start-version
ARG PHPMYADMIN_VERSION=5.2.1
# x-release-please-end

# Standard OCI Metadata (https://github.com/opencontainers/image-spec)
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="phpMyAdmin Image Based On Rocky" \
    org.opencontainers.image.description="Docker Images for phpMyAdmin on Rocky. (i386, amd64, arm32v5, arm32v7, arm64, mips64le, ppc64le, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/phpmyadmin" \
    org.opencontainers.image.base.name="snowdreamtech/php:8.4.21-nginx-rocky" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/phpmyadmin" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.created="${BUILDTIME}" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/phpmyadmin"

# x-release-please-start-version
LABEL org.opencontainers.image.version="${VERSION:-5.2.1}"
# x-release-please-end

# Runtime Environment Configuration
ENV KEEPALIVE=${KEEPALIVE} \
    CAP_NET_BIND_SERVICE=${CAP_NET_BIND_SERVICE} \
    LANG=${LANG} \
    UMASK=${UMASK} \
    DEBUG=${DEBUG} \
    PASSWORDLESS_SUDO=${PASSWORDLESS_SUDO} \
    PGID=${PGID} \
    PUID=${PUID} \
    USER=${USER} \
    WORKDIR=${WORKDIR} \
    PHPMYADMIN_VERSION=${PHPMYADMIN_VERSION} \
    PHPMYADMIN_PATH=${PHPMYADMIN_PATH}

# Additional tooling and configuration for phpMyAdmin
RUN set -eux \
    && dnf -y --allowerasing update \
    && dnf -y --allowerasing install \
    vim-enhanced curl tar \
    && mkdir -p ${PHPMYADMIN_PATH} \
    && curl -fsSL "https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages.tar.gz" -o phpMyAdmin.tar.gz \
    && tar -xzf phpMyAdmin.tar.gz -C ${PHPMYADMIN_PATH} --strip-components=1 \
    && rm -rf phpMyAdmin.tar.gz \
    && dnf -y --allowerasing autoremove \
    && dnf -y --allowerasing clean all \
    && rm -rf /var/cache/dnf \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Container Orchestration Files
COPY entrypoint.d /usr/local/bin/entrypoint.d

RUN chmod +x /usr/local/bin/entrypoint.d/*

# Standard Healthcheck (Verification of core system responsiveness)
HEALTHCHECK NONE

# Process Execution
EXPOSE 80 443
USER root
WORKDIR /root
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/bash"]
