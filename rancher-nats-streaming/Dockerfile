FROM golang:1.10.3 as build
LABEL MAINTAINER="kaiserli@gmail.com"

RUN git clone https://github.com/nats-io/nats-streaming-server.git /go/src/github.com/nats-io/nats-streaming-server
WORKDIR /go/src/github.com/nats-io/nats-streaming-server

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -a -tags netgo -installsuffix netgo -ldflags "-s -w -X github.com/nats-io/nats-streaming-server/version.GITCOMMIT=`git rev-parse --short HEAD`" -o /tmp/nats-streaming-server

FROM kaiserli/confd:v1

RUN mkdir -p /stan /data/stan
COPY --from=build /tmp/nats-streaming-server /stan/nats-streaming-server
COPY entrypoint.sh /bin/entrypoint.sh
ADD ./confd /etc/confd

RUN chmod +x /bin/entrypoint.sh /stan/nats-streaming-server

EXPOSE 4222 6222 8222

WORKDIR /stan
VOLUME [ "/data/stan" ]

ENTRYPOINT [ "/bin/entrypoint.sh" ]

