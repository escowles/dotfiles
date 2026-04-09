#!/bin/sh

BT=$(ioreg -r -l -k BatteryPercent | grep "BatteryPercent\" = \|DeviceAddress\"")
#echo "$BT"

function get_level {
  BT1="$1"
  BT2="$2"
  LVL=$(echo "$BT" | grep -A 1 "$BT1" | grep "BatteryPercent" | sed -e's/.* = //' )
  if [ "$LVL" ]; then
    echo $LVL
  else
    echo "$BT" | grep -A 1 "$BT2" | grep "BatteryPercent" | sed -e's/.* = //'
  fi
}

KLEVEL=$(get_level "68-fe-f7-4f-ad-6b" "1c-1d-d3-7b-5b-19")
MLEVEL=$(get_level "a8-91-3d-3f-7c-f0" "94-21-57-de-ad-7f")
echo "keyboard: $KLEVEL%, mouse: $MLEVEL%"
