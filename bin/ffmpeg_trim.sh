#!/bin/sh

START_TIME="5:01" # mm:ss or sss
DURATION="7:00"   # mm:ss or sss
IN="$1"
OUT="$2"
ffmpeg -i "$IN" -ss $START_TIME -t $DURATION -c copy "$OUT"
