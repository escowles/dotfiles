#!/bin/sh

# output bluetooth battery info
system_profiler SPBluetoothDataType 2>&1 | grep "Keyboard:\|Library Bluetooth\|Battery" | grep -v "Auto Seek\|system_profiler"
