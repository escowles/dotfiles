#!/bin/sh

# n.b., this only works if you have a princeton IP address
if [ ! "$1" ];then
  echo "usage $0 [netid]"
  exit 1
fi
ldapsearch -h ldap.princeton.edu -p 389 -x -b "o=Princeton University,c=US"  "uid=$1"
