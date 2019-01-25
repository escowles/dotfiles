#!/bin/sh

# run a figgy sidekiq worker

cd $HOME/src/figgy
bundle exec sidekiq -c 1 -q default -q low # --daemon --logfile tmp/sidekiq.log &
