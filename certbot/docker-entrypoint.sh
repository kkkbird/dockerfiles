#!/bin/sh
set -e;

# add --dry-run to test
if [ "$1" == "certonly" ]; then
    cmd="certbot certonly --text --non-interactive --agree-tos --email $LETSENCRYPT_EMAIL --webroot -w /var/www/certbot"
    if [ "$LETSENCRYPT_DRYRUN" == "true" ]; then
        cmd=$cmd" --dry-run"
    fi 

    if [ "0" = 0"$LETSENCRYPT_PARAMS" ]; then
        echo "no extra params"
    else
        cmd=$cmd" $LETSENCRYPT_PARAMS"
    fi

    if [ "$LETSENCRYPT_SEPERATE_CERTS" == "true" ]; then
        set +e;
        for h in $LETSENCRYPT_DOMAINS; do
            echo "$cmd -d $h"
            $cmd -d $h
            if [ "$?" -ne 0 ]; then
                echo "[Error] Domain $h fail to register"
            fi
        done
        set -e
    else
        for h in $LETSENCRYPT_DOMAINS; do
            cmd=$cmd" -d $h"
        done
        echo Running: $cmd
        exec $cmd
    fi
elif [ "$1" == "renew" ]; then
    if [ "$LETSENCRYPT_DRYRUN" == "true" ]; then
    #for dryrun, just run on time
        exec certbot renew --dry-run
    fi

    trap "exit 0" SIGINT SIGTERM

    while true; do
        sleep 24h;
        certbot renew;
    done
else
    exec "$@"
fi