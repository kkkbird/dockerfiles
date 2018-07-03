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

function CheckRunMode {
	if [ ! $RUN_MODE ]; then
		if [ "$RANCHER_ENABLE" = 'true' ]; then
			RUN_MODE=standalone-ft # set run mode to standalone ft in rancher by default
			
			if [ -z $NATS_URL ]; then
			echo "must set env var: NATS_URL"
				exit 1
			fi

			if [ ! $FT_GROUP ]; then
				FT_GROUP=ft
			fi

			if [ ! $STREAMING_STORE ]; then
				export STREAMING_STORE=file
			fi

		else
			RUN_MODE=
		fi	
	fi
}

CheckRancher
CheckRunMode

if [ "$RANCHER_ENABLE" = 'true' ]; then
	RANCHER_ENABLE=true confd -onetime -backend rancher -prefix /2015-12-19
else
	RANCHER_ENABLE=false confd -onetime -backend env
fi


case $RUN_MODE in
	standalone-ft)
		echo "run nats-streaming-server in stand alone ft mode"
		exec /stan/nats-streaming-server -ns $NATS_URL -ft_group "$FT_GROUP" -sc /stan/stan-ft.conf $@
		;;
	*)
		echo "run nats-streaming-server by default"
		exec /stan/nats-streaming-server -c /stan/gnatsd.conf -sc /stan/stan.conf $@
esac
	


