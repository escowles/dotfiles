#!/bin/sh

BT=$(ioreg -r -l -k BatteryPercent | grep "BatteryPercent\" = \|DeviceAddress\"")
#echo "$BT"

function get_level {
  BT_ID="$1"
  echo "$BT" | grep -A 1 "$BT_ID" | grep "BatteryPercent" | sed -e's/.* = //'
}

KLEVEL=$(get_level "68-fe-f7-4f-ad-6b")
MLEVEL=$(get_level "a8-91-3d-3f-7c-f0")
echo "keyboard: $KLEVEL%, mouse: $MLEVEL%"
