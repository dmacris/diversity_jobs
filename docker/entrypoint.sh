#!/bin/bash

# Remove a potentially pre-existing server.pid for Rails.
rm -rf tmp/pids/server.pid

# Checks if the dependencies listed in Gemfile are satisfied by currently installed gems
bundle clean

# Check whether or not gems are installed, and install it case not installed.
bundle check || bundle install --jobs=$(nproc) --retry=5

# If the wait-for-it fails, we want the script to stop
set -e

if [ -n "${WAIT_FOR}" ];
# We have to wait for some services to respond on their ports
then
    # creates an array with the specified host(s):port(s) and then wait for all of them to 
    # appear to be online before continuing
    readarray -td ' ' SERVICES<<<"$WAIT_FOR "; 
    unset 'SERVICES[-1]';
    for SERVICE in "${SERVICES[@]}"; do
        wait-for-it -t ${WAIT_FOR_TIMEOUT-15} $SERVICE -s
    done
fi

exec "$@"
