#!/usr/bin/env bash
set -e

if [ -n "$CONFD_ONETIME" ]; then    
    cmd="/usr/bin/confd -onetime"
    if [ -n "$CONFD_DIR" ]; then
        cmd="$cmd -confdir=$CONFD_DIR"
    fi
    cmd="$cmd $CONFD_ONETIME"
    
    echo $cmd
    $cmd
fi

exec "$@"