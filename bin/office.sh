#!/bin/sh

# use hue to set office light levels

FULL_LIGHTS=7,8,9
HALF_LIGHTS=1
ALL_LIGHTS=$FULL_LIGHTS,$HALF_LIGHTS
VAL=210
if [ "$1" = "max" ];then
  VAL=255
elif [ "$1" ]; then
  VAL=$1
fi
HALF_VAL=$(( $VAL / 2 ))

if [ "$1" = 'off' -o "$1" = '0' ]; then
  hue lights $ALL_LIGHTS off
else
  hue lights $ALL_LIGHTS on
  hue lights $FULL_LIGHTS =$VAL
  hue lights $HALF_LIGHTS =$HALF_VAL
fi
