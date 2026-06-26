#!/bin/sh

# strip querystring and/or anchors with trurl
ORIG=$(pbpaste)
trurl --url "$ORIG" --set "query=" --set "fragment=" | pbcopy
pbpaste
