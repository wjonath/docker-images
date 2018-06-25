FROM alpine:3.7

MAINTAINER Maksym Nebot <maksym.nebot@accenture.com>

ENV LDAP_SERVER_NAME 'ADOP LDAP'
ENV LDAP_SERVER_HOST 'ldap'
ENV LDAP_SERVER_PORT '389'
ENV LDAP_SERVER_BIND_ID 'cn=admin,dc=ldap,dc=example,dc=com'
ENV LDAP_SERVER_BASE_DN 'dc=ldap,dc=example,dc=com'

RUN apk update \
    && apk add bash nginx ca-certificates \
    php7-fpm php7-json php7-zlib php7-xml php7-pdo php7-phar php7-openssl \
    php7-pdo_mysql php7-mysqli \
    php7-gd php7-iconv php7-mcrypt php7-ldap phpldapadmin

RUN rm -rf /var/cache/apk/*

WORKDIR ["/usr/share/webapps/phpldapadmin/htdocs"]

ADD files/config.php /usr/share/webapps/phpldapadmin/config/
ADD files/nginx.conf /etc/nginx/
ADD files/php-fpm.conf /etc/php/

ADD files/run.sh /
RUN chmod +x /run.sh

EXPOSE 80

CMD ["/run.sh"]
