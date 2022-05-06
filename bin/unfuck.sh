#!/bin/sh

# unwrap and url-decode safelinks - copy the real url to the clipboard and echo for confirmation
ENCODED=$(pbpaste | sed -e's/.*\?url=//' -e's/&.*//')
echo "${ENCODED//%/\\x}" | pbcopy
pbpaste
