FROM golang:1.10.1 AS build

RUN go get github.com/kelseyhightower/confd

RUN go build -o /tmp/confd github.com/kelseyhightower/confd 


FROM kaiserli/ubuntu-cn:16.04-1

COPY --from=build /tmp/confd /usr/bin/confd
COPY entrypoint.sh /bin/entrypoint.sh

RUN mkdir -p /etc/confd/conf.d /etc/confd/templates \
    && chmod +x /bin/entrypoint.sh /usr/bin/confd

ENTRYPOINT [ "entrypoint.sh" ]


