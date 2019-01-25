#!/bin/sh

# open a local file in a github repo in the github.com website

BRANCH=`git status | grep "On branch" | cut -d\  -f3`
echo $BRANCH

PWD=`pwd`
STEM=`git remote -v| grep origin | grep fetch | sed -e's/.*@//' -e's/\.git.*//' -e's/:/\//'`
BASE="https://$STEM"
echo $BASE

if [ -f "$1" ]; then
	TYPE=blob
else
	TYPE=tree
fi
open $BASE/$TYPE/$BRANCH$FILEPATH/$1
