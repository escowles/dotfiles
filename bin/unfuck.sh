#!/bin/sh

# unwrap and url-decode safelinks - copy the real url to the clipboard and echo for confirmation
ORIG=$(pbpaste)
trurl --url "$ORIG" --get "{query:url}" | pbcopy
pbpaste
