#!/bin/sh

# stop redis
PIDS=`ps x | grep "redis"| grep -v stop_redis.sh | grep -v grep | awk '{print $1}'`
if [ "$PIDS" ]; then
	echo "killing redis: $PIDS"
	kill $PIDS
	sleep 3
else
	echo "redis not running"
fi
