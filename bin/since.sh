#!/bin/bash

OTHER=$1
if [ ! "$OTHER" ]; then
  OTHER=2020-03-12
fi

NOW=`date +%s`
THEN=`date -j -f "%Y-%m-%d" +%s "$OTHER"`
DIFF=$(( ($NOW - $THEN) / (3600*24) ))
if [ ${DIFF:0:1} = "-" ]; then
  echo ${DIFF:1} days until $OTHER
elif [ "$DIFF" = "0" ]; then
  echo today is $OTHER
else
  echo $DIFF days since $OTHER
fi
