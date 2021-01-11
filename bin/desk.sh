#!/bin/sh

# use hue to set office light levels

LIGHTS=1
VAL=100
if [ "$1" -a "$1" != "lo" ]; then
  VAL=$1
fi

if [ "$1" = 'off' -o "$1" = '0' ]; then
  hue lights $LIGHTS off
elif [ "$1" = 'hi' ]; then
  hue lights $LIGHTS on
  hue lights $LIGHTS =180
else
  hue lights $LIGHTS on
  hue lights $LIGHTS =$VAL
fi
