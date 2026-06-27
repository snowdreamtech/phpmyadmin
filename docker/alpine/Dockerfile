# Base Image (Alpine Variant)
# Extends snowdreamtech/php with additional tooling and configuration.

FROM snowdreamtech/php:8.4.22-nginx-alpine

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
ARG PHPMYADMIN_VERSION=5.2.3
# x-release-please-end

# Standard OCI Metadata (https://github.com/opencontainers/image-spec)
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="phpMyAdmin Image Based On Alpine" \
    org.opencontainers.image.description="Docker Images for phpMyAdmin on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le, riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/phpmyadmin" \
    org.opencontainers.image.base.name="snowdreamtech/php:8.4.22-nginx-alpine" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/phpmyadmin" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.created="${BUILDTIME}" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/phpmyadmin"

# x-release-please-start-version
LABEL org.opencontainers.image.version="${VERSION:-5.2.3}"
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
RUN apk update \
    && apk add --no-cache \
    vim curl tar \
    && mkdir -p ${PHPMYADMIN_PATH} \
    && curl -fsSL "https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages.tar.gz" -o phpMyAdmin.tar.gz \
    && tar -xzf phpMyAdmin.tar.gz -C ${PHPMYADMIN_PATH} --strip-components=1 \
    && rm -rf phpMyAdmin.tar.gz

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
CMD ["/bin/sh"]
