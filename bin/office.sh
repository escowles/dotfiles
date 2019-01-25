#!/bin/sh

# use hue to set office light levels

FULL_LIGHTS=3,15
HALF_LIGHTS=6,16
VAL=210
if [ "$1" ]; then
  VAL=$1
fi
HALF_VAL=$(( $VAL / 2 ))

if [ "$1" = 'off' -o "$1" = '0' ]; then
  hue lights $HALF_LIGHTS,$FULL_LIGHTS off
else
  hue lights $HALF_LIGHTS,$FULL_LIGHTS on
  hue lights $FULL_LIGHTS =$VAL
  hue lights $HALF_LIGHTS =$HALF_VAL
fi
