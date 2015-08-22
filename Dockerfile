FROM alpine:edge
MAINTAINER Etopian Inc. <contact@etopian.com>

LABEL devoply.type="site"
LABEL devoply.cms="drupal"
LABEL devoply.framework="drupal"
LABEL devoply.language="php"
LABEL devoply.require="mariadb etopian/nginx-proxy"
LABEL devoply.recommend="redis"
LABEL devoply.description="Drupal on Nginx and PHP-FPM with Drush."
LABEL devoply.name="Drupal"


# BUILD NGINX
ENV NGINX_VERSION nginx-1.9.3

# Add s6-overlay
ENV S6_OVERLAY_VERSION v1.14.0.0

ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz
RUN tar xvfz /tmp/s6-overlay.tar.gz -C /

ADD root /

# Add the files
RUN rm /etc/s6/services/s6-fdholderd/down

RUN apk --update add nginx && apk del nginx

RUN apk --update add pcre openssl-dev pcre-dev zlib-dev wget build-base \
    ca-certificates git linux-headers && \
    mkdir -p /tmp/src && \
    cd /tmp/src && \
    wget http://nginx.org/download/${NGINX_VERSION}.tar.gz && \
    wget https://raw.githubusercontent.com/masterzen/nginx-upload-progress-module/master/ngx_http_uploadprogress_module.c && \
    git clone https://github.com/masterzen/nginx-upload-progress-module /tmp/nginx-upload-progress-module && \
    tar -zxvf ${NGINX_VERSION}.tar.gz && \
    cd /tmp/src/${NGINX_VERSION} && \
    ./configure \
        --conf-path=/etc/nginx/nginx.conf \
        --with-http_ssl_module \
        --with-http_gzip_static_module \
        --with-pcre \
        --with-file-aio \
        --with-http_flv_module \
        --with-http_realip_module \
        --with-http_mp4_module \
        --with-http_stub_status_module \
        --with-http_gunzip_module \
        --add-module=/tmp/nginx-upload-progress-module \
        --prefix=/etc/nginx \
        --http-log-path=/var/log/nginx/access.log \
        --error-log-path=/var/log/nginx/error.log \
        --sbin-path=/usr/local/sbin/nginx && \
    make && \
    make install && \
    apk del --purge build-base openssl-dev zlib-dev git && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*




RUN apk update \
    && apk add bash less vim ca-certificates \
    php-fpm php-json php-zlib php-xml php-pdo php-phar php-openssl \
    php-pdo_mysql php-mysqli \
    php-gd php-iconv php-mcrypt \
    php-mysql php-curl php-opcache php-ctype php-apcu \
    php-intl php-bcmath php-dom php-xmlreader curl git \ 
    mysql-client php-pcntl php-posix apk-cron

# fix php-fpm "Error relocating /usr/bin/php-fpm: __flt_rounds: symbol not found" bug
RUN apk add -u musl
RUN rm -rf /var/cache/apk/*
RUN rm -rvf /etc/nginx && mkdir -p /etc/nginx

ADD files/nginx/ /etc/nginx/


ADD files/php-fpm.conf /etc/php/
#ADD files/run.sh /
#RUN chmod +x /run.sh

ADD files/drush.sh /
RUN chmod +x /drush.sh
RUN mkdir -p /DATA/htdocs /DATA/logs/nginx /DATA/logs/ /DATA/logs/php-fpm /DATA/logs/nginx && \ 
    mkdir -p /var/log/nginx/ && mkdir -p /var/lib/nginx/ && mkdir -p /var/cache/nginx/microcache && \ 
    chown -R nginx:nginx /var/log/nginx/ && chown -R nginx:nginx /var/lib/nginx/ && \ 
    chown -R nginx:nginx /var/cache/nginx && mkdir -p /var/www/localhost/htdocs && chown -R nginx:nginx /var/www/localhost/htdocs
RUN /drush.sh

RUN sed -i 's/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/sbin\/nologin/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/bin\/bash/g' /etc/passwd
RUN sed -i 's/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/sbin\/nologin/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/bin\/bash/g' /etc/passwd-

# configure amazon ses to send mail.
RUN apk --update add postfix
ENV SES_HOST="email-smtp.us-east-1.amazonaws.com" SES_PORT="587" \
    SES_USER="" SES_SECRET=""


ENV TERM="xterm" DB_HOST="172.17.42.1" DB_USER="" DB_PASS="" DB_NAME=""


EXPOSE 80
VOLUME ["/DATA"]
ENTRYPOINT ["/init"]
#CMD ["/run.sh"]
