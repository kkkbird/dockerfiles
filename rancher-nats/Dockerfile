FROM golang:1.9.4 as gnatsdbuild

LABEL MAINTAINER="kaiserli@gmail.com"

RUN go get github.com/nats-io/gnatsd
WORKDIR /go/src/github.com/nats-io/gnatsd

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -a -tags netgo -installsuffix netgo -ldflags "-s -w -X github.com/nats-io/gnatsd/server.gitCommit=`git rev-parse --short HEAD`" -o /tmp/gnatsd

FROM kaiserli/confd:v1

RUN mkdir -p /gnatsd
COPY --from=gnatsdbuild /tmp/gnatsd /gnatsd/gnatsd
COPY entrypoint.sh /bin/entrypoint.sh
COPY reload.sh /gnatsd/reload.sh
ADD ./confd /etc/confd

RUN chmod +x /bin/entrypoint.sh /gnatsd/gnatsd /gnatsd/reload.sh

WORKDIR /gnatsd

ENTRYPOINT [ "/bin/entrypoint.sh" ]

