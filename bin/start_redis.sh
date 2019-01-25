#!/bin/sh

cd /tmp/
nohup redis-server > redis.log 2>&1 &
