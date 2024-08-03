FROM snowdreamtech/php:8.1.29

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

ENV PMA_ARBITRARY=0

RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/v3.17/community phpmyadmin=5.2.1-r0
    
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["php","-S","0.0.0.0:80","-t","/usr/share/webapps/phpmyadmin/"]