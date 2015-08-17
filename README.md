##### This image is being maintained. No need to fork it. Upgrade your site using the upgrade strategy on dockerwordpress.com

http://www.dockerwordpress.com/docker/upgrading-wordpress-docker


# Lightweight WordPress PHP-FPM & Nginx Docker Image

http://www.dockerwordpress.com

Lightwight Docker image for the (latest) PHP-FPM and Nginx to run WordPress based on [AlpineLinux](http://alpinelinux.org)

* Image size only ~50MB !
* Very new packages (alpine:edge) 2015-04-03:
  * [PHP](http://pkgs.alpinelinux.org/package/main/x86/php) 5.6.7
  * [Nginx](http://pkgs.alpinelinux.org/package/main/x86/nginx) 1.6.2
  * Memory usage is around 50mb on a simple install.
  
  
## A simple example
### Say you want to run a single site on a VPS with Docker

```bash

mkdir -p /data/sites/etopian.com/htdocs

sudo docker run -e VIRTUAL_HOST=etopian.com,www.etopian.com -v /data/sites/etopian.com:/DATA -p 80:80 etopian/alpine-php-wordpress

```
The following user and group id are used, the files should be set to this:
User ID: 
Group ID: 

```bash
chown -R 100:101 /data/sites/etopian.com/htdocs
```

### Say you want to run a multiple WP sites on a VPS with Docker

```bash

sudo docker run -p 80:80 etopian/nginx-proxy
mkdir -p /data/sites/etopian.com/htdocs

sudo docker run -e VIRTUAL_HOST=etopian.com,www.etopian.com -v /data/sites/etopian.com:/DATA etopian/alpine-php-wordpress

mkdir -p /data/sites/etopian.net/htdocs
sudo docker run -e VIRTUAL_HOST=etopian.net,www.etopian.net -v /data/sites/etopian.net:/DATA etopian/alpine-php-wordpress
```

Populate /data/sites/etopian.com/htdocs and  /data/sites/etopian.net/htdocs with your WP files. See http://www.dockerwordpress.com if you need help on how to configure your database.

The following user and group id are used, the files should be set to this:
User ID: 
Group ID: 

```bash
chown -R 100:101 /data/sites/etopian.com/htdocs
```



### Volume structure

* `htdocs`: Webroot
* `logs`: Nginx/PHP error logs
* 

### WP-CLI

This image now includes WP-CLI wpcli.org baked in... So you can 

```
docker exec -it <container_name> bash
cd /DATA/htdocs
wp-cli.phar cli
```

### PHP Modules
#### List of available modules in Alpine Linux, not all these are installed.
##### In order to install a php module do, (leave out the version number i.e. -5.6.11-r0
```
docker exec <image_id> apk add <pkg_name>
docker restart <image_name>
```
Example:

```
docker exec <image_id> apk add php-soap
docker restart <image_name>
```


php-soap-5.6.11-r0

php-openssl-5.6.11-r0

php-gmp-5.6.11-r0

php-phar-5.6.11-r0

php-embed-5.6.11-r0

php-pdo_odbc-5.6.11-r0

php-mysqli-5.6.11-r0

php-common-5.6.11-r0

php-ctype-5.6.11-r0

php-fpm-5.6.11-r0

php-shmop-5.6.11-r0

php-xsl-5.6.11-r0

php-curl-5.6.11-r0

php-pear-net_idna2-0.1.1-r0

php-json-5.6.11-r0

php-dom-5.6.11-r0

php-pspell-5.6.11-r0

php-sockets-5.6.11-r0

php-pear-mdb2-driver-pgsql-2.5.0b5-r0

php-pdo-5.6.11-r0

phpldapadmin-1.2.3-r3

php-pear-5.6.11-r0

php-phpmailer-5.2.0-r0

phpmyadmin-doc-4.4.10-r0

php-cli-5.6.11-r0

php-zip-5.6.11-r0

php-pgsql-5.6.11-r0

php-sysvshm-5.6.11-r0

php-imap-5.6.11-r0

php-intl-5.6.11-r0

php-embed-5.6.11-r0

php-zlib-5.6.11-r0

php-phpdbg-5.6.11-r0

php-sysvsem-5.6.11-r0

phpmyadmin-4.4.10-r0

php-mysql-5.6.11-r0

php-sqlite3-5.6.11-r0

php-cgi-5.6.11-r0

php-apcu-4.0.7-r1

php-snmp-5.6.11-r0

php-pdo_pgsql-5.6.11-r0

php-xml-5.6.11-r0

php-wddx-5.6.11-r0

php-sysvmsg-5.6.11-r0

php-enchant-5.6.11-r0

php-bcmath-5.6.11-r0

php-pear-mail_mime-1.8.9-r0

php-apache2-5.6.11-r0

php-gd-5.6.11-r0

php-pear-mdb2-driver-sqlite-2.5.0b5-r0

php-xcache-3.2.0-r1

php-odbc-5.6.11-r0

php-mailparse-2.1.6-r2

php-ftp-5.6.11-r0

perl-php-serialization-0.34-r1

php-exif-5.6.11-r0

php-pdo_mysql-5.6.11-r0

php-ldap-5.6.11-r0

php-pear-mdb2-2.5.0b5-r0

php-dbg-5.6.11-r0

php-pear-net_smtp-1.6.2-r0

php-opcache-5.6.11-r0

php-pdo_sqlite-5.6.11-r0

php-posix-5.6.11-r0

php-dba-5.6.11-r0

php-iconv-5.6.11-r0

php-gettext-5.6.11-r0

php-xmlreader-5.6.11-r0

php-5.6.11-r0

php-xmlrpc-5.6.11-r0

php-bz2-5.6.11-r0

perl-php-serialization-doc-0.34-r1

php-mcrypt-5.6.11-r0

php-memcache-3.0.8-r3

xapian-bindings-php-1.2.21-r1

php-pdo_dblib-5.6.11-r0

php-phalcon-2.0.3-r0

php-dev-5.6.11-r0

php-doc-5.6.11-r0

php-mssql-5.6.11-r0

php-calendar-5.6.11-r0

php-pear-mdb2-driver-mysqli-2.5.0b5-r0

php-pear-mdb2-driver-mysql-2.5.0b5-r0

