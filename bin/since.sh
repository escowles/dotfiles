#!/bin/bash

PAST=$1
if [ ! "$PAST" ]; then
  PAST=2020-03-12
fi

NOW=`date +%s`
THEN=`date -j -f "%Y-%m-%d" +%s "$PAST"`
echo $(( ($NOW - $THEN) / (3600*24) )) days since $PAST
