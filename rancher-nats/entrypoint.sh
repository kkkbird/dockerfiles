#!/bin/bash
set -e

function CheckRancher {
    inrancher="`ping -c 1 rancher-metadata.rancher.internal &> /dev/null; echo $?`"		
	if [ $inrancher = 0 ]; then
		echo "Run in rancher..."
		RANCHER_ENABLE=true
	else
		echo "Not in rancher"
	fi
}

CheckRancher

if [ "$RANCHER_ENABLE" = 'true' ]; then
	RANCHER_ENABLE=true confd -onetime -backend rancher -prefix /2015-12-19
	RANCHER_ENABLE=true confd -watch -backend rancher -prefix /2015-12-19 &
else
	RANCHER_ENABLE=false confd -onetime -backend env
fi

exec /gnatsd/gnatsd -c /gnatsd/gnatsd.conf $@
