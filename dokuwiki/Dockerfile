FROM alpine:3.6
MAINTAINER jonath <jonath@163.com>

ENV DOKUWIKI_VERSION "2018-04-22a"
ENV DOKUWIKI_FILE "dokuwiki-$DOKUWIKI_VERSION.tgz"
ENV DOWNLOAD_URL "https://download.dokuwiki.org/src/dokuwiki/$DOKUWIKI_FILE"
ENV MD5_CHECKSUM 18765a29508f96f9882349a304bffc03

RUN apk update && apk --no-cache add \
 	php7 php7-fpm php7-gd php7-session php7-xml php7-openssl php7-json php7-zlib php7-iconv php7-dom \
	nginx supervisor curl tar ca-certificates

RUN mkdir -p /run/nginx /var/www/dokuwiki && \
    cd /var/www && \
    curl -O -L "$DOWNLOAD_URL" && \
    tar -xzf "$DOKUWIKI_FILE" --strip 1 -C /var/www/dokuwiki && \
    rm -f "$DOKUWIKI_FILE"

ADD nginx.conf /etc/nginx/nginx.conf
ADD supervisord.conf /etc/supervisord.conf
ADD entrypoint.sh /entrypoint.sh

RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php7/php-fpm.ini && \
    sed -i -e "s|;daemonize\s*=\s*yes|daemonize = no|g" /etc/php7/php-fpm.conf && \
    sed -i -e "s|listen\s*=\s*127\.0\.0\.1:9000|listen = /var/run/php-fpm7.sock|g" /etc/php7/php-fpm.d/www.conf && \
    sed -i -e "s|;listen\.owner\s*=\s*|listen.owner = |g" /etc/php7/php-fpm.d/www.conf && \
    sed -i -e "s|;listen\.group\s*=\s*|listen.group = |g" /etc/php7/php-fpm.d/www.conf && \
    sed -i -e "s|;listen\.mode\s*=\s*|listen.mode = |g" /etc/php7/php-fpm.d/www.conf && \
    chmod +x /entrypoint.sh

EXPOSE 80
VOLUME ["/var/www/dokuwiki"]

CMD /entrypoint.sh
