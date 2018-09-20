FROM nginx:1.15.3-alpine

LABEL MAINTAINER="Li Kaiye <kaiye.li@ti-link.com.cn>"

RUN apk update && apk upgrade \
    && apk add --update-cache tzdata ca-certificates \
    && rm -rf /var/cache/apk/*
ENV TZ=Asia/Shanghai NGINX_VERSION=1.15.3

COPY nginx.conf /etc/nginx/nginx.conf
RUN chmod 644 /etc/nginx/nginx.conf

EXPOSE 80 443

VOLUME /etc/nginx/conf.d

