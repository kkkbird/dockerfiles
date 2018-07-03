# rancher-nats-streaming

a nats docker image for rancher

## example

rancher nats-streaming stack with 3 nats and 2 nats-streaming in FT mode

docker-compose.yml

```yaml
version: '2'
volumes:
  nats-streaming:
    external: true
    driver: rancher-nfs
services:
  nats:
    image: kaiserli/rancher-nats:v1
    environment:
      AUTH_USER: myuser
      AUTH_PASS: mypassword
    stdin_open: true
    tty: true
    ports:
    - 8222:8222/tcp
    - 4222:4222/tcp
    labels:
      io.rancher.container.pull_image: always
      io.rancher.scheduler.affinity:host_label: nats=true
  nats-streaming:
    image: kaiserli/rancher-nats-streaming:v1
    environment:
      NATS_URL: nats://myuser:mypassword@nats:4222
    stdin_open: true
    volumes:
    - nats-streaming:/data/stan
    tty: true
    links:
    - nats:nats
    ports:
    - 8224:8222/tcp
    command:
    - -m
    - '8222'
    labels:
      io.rancher.container.pull_image: always
```

rancher-compose.yml

```yaml
version: '2'
services:
  nats:
    retain_ip: true
    scale: 3
    start_on_create: true
  nats-streaming:
    scale: 2
    start_on_create: true
```
