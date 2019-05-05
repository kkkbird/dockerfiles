FROM nginx:1.16.0-alpine

LABEL MAINTAINER="Kaiser Li <kaiserli@gmail.com>"

RUN apk update && apk upgrade \
    && apk add --update-cache tzdata ca-certificates \
    && rm -rf /var/cache/apk/*
ENV TZ=Asia/Shanghai NGINX_VERSION=1.16.0

COPY nginx.conf /etc/nginx/nginx.conf
RUN chmod 644 /etc/nginx/nginx.conf

EXPOSE 80 443

VOLUME /etc/nginx/conf.d

