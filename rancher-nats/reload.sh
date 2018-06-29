#!/bin/bash
set -e
isrunning=`ps aux|grep gnatsd|grep -v grep|wc -l`

if [ $isrunning = 1 ]; then
    echo reload gnatsd...
    /gnatsd/gnatsd -sl reload
else
    echo gnatsd is not running!
fi