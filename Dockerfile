FROM alpine:edge
MAINTAINER Etopian Inc. <contact@etopian.com>

RUN apk update \
    && apk add bash less vim nginx ca-certificates \
    php-fpm php-json php-zlib php-xml php-pdo php-phar php-openssl \
    php-pdo_mysql php-mysqli \
    php-gd php-iconv php-mcrypt \
    php-mysql php-curl php-opcache php-ctype php-apcu \
    php-intl php-bcmath php-dom php-xmlreader curl git mysql-client php-pcntl php-posix

# fix php-fpm "Error relocating /usr/bin/php-fpm: __flt_rounds: symbol not found" bug
RUN apk add -u musl
RUN rm -rf /var/cache/apk/*
RUN rm -rvf /etc/nginx


ADD files/nginx/ /etc/nginx/


ADD files/php-fpm.conf /etc/php/
ADD files/run.sh /
RUN chmod +x /run.sh

ADD files/drush.sh /
RUN chmod +x /drush.sh
RUN mkdir -p /var/cache/nginx/microcache && chown -R nginx:nginx /var/lib/nginx/ && chown -R nginx:nginx /var/cache/nginx
RUN /drush.sh


ENV TERM="xterm" DATABASE_HOST="172.17.42.1"


EXPOSE 80
VOLUME ["/DATA"]

CMD ["/run.sh"]
