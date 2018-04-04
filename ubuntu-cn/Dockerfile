FROM ubuntu:16.04

LABEL maintainer="kaiserli@gmail.com"

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime\
    && echo "Asia/Shanghai" > /etc/timezone\
    && sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list\    
	&& apt-get update \
	&& apt-get install -y ca-certificates gosu curl iputils-ping\
    && rm -rf /var/lib/apt/lists/*

