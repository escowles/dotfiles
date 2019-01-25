#!/bin/bash

# termpos.sh - set terminal size/position using xterm escapes
#    stopped working macosx a long time ago...

while getopts 'x:y:c:r:' thisArg; do
	case "${thisArg}" in
		x) xval="${OPTARG}" ;;
		y) yval="${OPTARG}" ;;
		c) cols="${OPTARG}" ;;
		r) rows="${OPTARG}" ;;
	esac
done

echo "$xval x $yval; $cols x $rows"

if [ "$xval" -a "$yval" ]; then
	echo -en $'\e[3;'${xval}';'${yval}'t'
fi
if [ "$rows" -a "$cols" ]; then
	echo -en $'\e[4;'${rows}';'${cols}'t'
	echo
fi
