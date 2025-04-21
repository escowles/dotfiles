#!/bin/sh

FILES="r1c1.png r1c2.png r1c3.png r2c1.png r2c2.png r2c3.png"
FILES="$FILES r3c1.png r3c2.png r3c3.png r4c1.png r4c2.png r4c3.png"
GEOM="650x462+0+0"
TILE="3x4" # cols x rows
OUT="montage.png"

montage -verbose +frame +shadow +label -geometry $GEOM -tile $TILE $FILES $OUT
