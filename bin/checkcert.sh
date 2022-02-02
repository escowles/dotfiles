#!/bin/sh

WARN_DAYS=7

URL=${1:-https://catalog.princeton.edu}
EXP=`curl --insecure -v $URL 2>&1 | grep "*  expire date" | sed -e's/*  expire date: //'`
EXP_S=`date -j -f "%B %e %H:%M:%S %Y %Z" +%s "$EXP"`
NOW_S=`date +%s`
EXP_IN=$(( ($EXP_S - $NOW_S) / (3600*24) ))
if [ $EXP_IN -lt $WARN_DAYS ]; then
  WARN="DANGER "
fi
echo "$WARN$URL $EXP_IN days until expiration ($EXP)"
