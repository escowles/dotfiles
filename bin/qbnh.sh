#!/bin/sh

for i in ~/desktop/Screenshot*.png; do
  FN=`basename "$i" .png | sed -e's/Screenshot //' -e's/ at /T0/' -e's/.AM//' -e's/\./-/g'`
  mv -v "$i" ~/downloads/qbnh/qbnh-${FN}.png
done

START_DATE=2026-03-29
START_S=`date -j -f "%Y-%m-%d" +%s $START_DATE`
TODAY_S=`date +%s`
DIFF=$(( ($TODAY_S - $START_S) / (3600*24) ))
QBNH=`ls ~/downloads/qbnh | wc -l | tr -d ' '`
PCT=$(( ($QBNH * 100) / $DIFF ))
echo "$QBNH / $DIFF ($PCT%)"
