#!/bin/sh

DIR=$HOME/src/wasteland/_posts

DATE=`date +"%F"`
DATE2=`date +"%m/%d/%Y"`
TIME=`date +"%T %z"`
TITLE=$*
if [ "$TITLE" = "" ]; then
    TITLE="untitled"
fi
SLUG=`echo $TITLE | tr ' ' '-'`
FILE=$DATE-$SLUG.md

if [ -f $DIR/$FILE ]; then
    echo "file exists: $DIR/$FILE"
    exit 1
fi

echo "---"                > $DIR/$FILE
echo "layout: post"      >> $DIR/$FILE
echo "title: $TITLE"     >> $DIR/$FILE
echo "date: $DATE $TIME" >> $DIR/$FILE
echo "---"               >> $DIR/$FILE
echo ""                  >> $DIR/$FILE
echo "$DATE2: body here" >> $DIR/$FILE

echo $DIR/$FILE
vi $DIR/$FILE
