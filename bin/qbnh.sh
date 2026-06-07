#!/bin/sh

for i in ~/desktop/Screenshot*.png; do
  FN=`basename "$i" .png | sed -e's/Screenshot //' -e's/ at /T0/' -e's/.AM//' -e's/\./-/g'`
  mv -v "$i" ~/downloads/qbnh/qbnh-${FN}.png
done
