#!/bin/sh

#pg_ctl -D /usr/local/var/postgres -l /usr/local/log/postgres.log start
brew services start postgres
