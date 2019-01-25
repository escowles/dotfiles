#!/bin/sh

# force solr to commit its index

if [ ! "$1" ]; then
  echo "usage: solr_commit.sh [solr url]"
  exit 1
fi

curl -X POST -d "<commit/>" -H "Content-type: application/xml" $1/update
