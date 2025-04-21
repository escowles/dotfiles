#!/bin/sh

DIR=$HOME/src/recipes/_posts

DATE=`date +"%F"`
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

CATS="main|dessert|sides|other"

echo "---"                 > $DIR/$FILE
echo "layout: post"       >> $DIR/$FILE
echo "title: $TITLE"      >> $DIR/$FILE
echo "date: $DATE $TIME"  >> $DIR/$FILE
echo "last_modified_at: " >> $DIR/$FILE
echo "category: $CATS"    >> $DIR/$FILE
echo "tags: x y z"        >> $DIR/$FILE
echo "status: draft"      >> $DIR/$FILE
echo "---"                >> $DIR/$FILE
echo ""                   >> $DIR/$FILE
echo "body goes here"     >> $DIR/$FILE

echo $DIR/$FILE
vi $DIR/$FILE
