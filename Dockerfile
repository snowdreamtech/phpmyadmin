FROM snowdreamtech/php:8.1.29

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

RUN apk add --no-cache phpmyadmin=5.2.1-r2
    
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["php","-S","0.0.0.0:80","-t","/usr/share/webapps/phpmyadmin/"]