FROM certbot/certbot:latest

COPY ./docker-entrypoint.sh /usr/bin/docker-entrypoint.sh

RUN chmod +x /usr/bin/docker-entrypoint.sh

ADD ./conf.d /etc/nginx/conf.d

VOLUME /etc/letsencrypt \
    /var/www/certbot

ENV LETSENCRYPT_EMAIL=dev@example.com \
    LETSENCRYPT_DRYRUN=true \
    LETSENCRYPT_DOMAINS=www.example.com\
    LETSENCRYPT_PARAMS=

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
#CMD ["true"]


