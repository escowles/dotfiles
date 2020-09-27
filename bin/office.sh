#!/bin/sh

# use hue to set office light levels

LIGHTS=7,8,9
VAL=210
if [ "$1" ]; then
  VAL=$1
fi

if [ "$1" = 'off' -o "$1" = '0' ]; then
  hue lights $LIGHTS off
else
  hue lights $LIGHTS on
  hue lights $LIGHTS =$VAL
fi
