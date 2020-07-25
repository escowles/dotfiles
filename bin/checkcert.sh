#!/bin/sh

URL=${1:-https://catalog.princeton.edu}
EXP=`curl --insecure -v $URL 2>&1 | grep "*  expire date" | sed -e's/*  expire date: //'`
echo $EXP
EXP_S=`date -j -f "%B %e %H:%M:%S %Y %Z" +%s "$EXP"`
NOW_S=`date +%s`
echo $URL $(( ($EXP_S - $NOW_S) / (3600*24) )) days until expiration
