#!/bin/sh

# strip anchors and querystring from URLs
pbpaste | sed -e's/\?.*//' -e's/#.*//' | pbcopy
pbpaste
