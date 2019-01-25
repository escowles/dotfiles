#!/bin/sh

# render a markdown file using github's webservice

FILE=$1
if [ ! "$FILE" -o ! -f "$FILE" ]; then
	echo "usage: $0 [file]"
	exit 1
fi
URL=https://api.github.com/markdown/raw

echo "<html>"
echo "<head>"
echo "<link href='https://assets-cdn.github.com/assets/github-c0c2293be58dbb87efbe15f0252a75aa7f738724.css' media='all' rel='stylesheet' type='text/css' />"
echo "<link href='https://assets-cdn.github.com/assets/github2-2c7d4f87e135381585a949e74aa65d44cca0232f.css' media='all' rel='stylesheet' type='text/css' />"
echo "</head>"
echo "<body>"
echo "<div id='wiki-body' class='gollum-markdown-content instapaper_body'>"
echo "<div class='markdown-body'>"

curl -s -X POST -T "$FILE" -H "Content-Type: text/plain" $URL
echo "</div></div></body></html>"
