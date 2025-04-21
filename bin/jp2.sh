#!/bin/sh

# jp2.sh - convert lossless TIFFs to JPEG2000 using Kakadu
#   by default, lossy compression and color will be used
#   set LOSSLESS= to anything to enable lossless compression
#   set GRAY= to anything for grayscale source TIFFs
if [ ! -z "$LOSSLESS" ]; then
  # add lossless layer
  LAYERS=9
  LAYER_PRE="-,"
else
  LAYERS=8
fi

if [ ! -z "$GRAY" ]; then
  COLOR=LUM
else
  COLOR=RGB
fi

JP2=`basename "$1" .tif`.jp2
echo "kdu_compress -rate ${LAYER_PRE}2.4,1.48331273,.91673033,.56657224,.35016049,.21641118,.13374944,.08266171 -jp2_space s${COLOR} -double_buffering 10 -num_threads 1 -no_weights Clevels=6 Clayers=$LAYERS Cblk=\{64,64\} Cuse_sop=yes Cuse_eph=yes Corder=RPCL ORGgen_plt=yes ORGtparts=R Stiles=\{1024,1024\} -i "$1" -o "$JP2""
