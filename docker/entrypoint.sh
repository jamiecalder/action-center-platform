#!/bin/bash
set -e

rm -rf tmp/

if [ "$DB_AUTO_MIGRATE" == "true" ]; then
  bin/rake db:migrate
fi

if [ "$TEST_DB_AUTO_MIGRATE" == "true" ]; then
  bin/rake db:migrate RAILS_ENV=test
fi

# Download and precompile assets
bin/rake webshims:update_public
if [ "$RAILS_ENV" == "production" ]; then
  bin/rake assets:precompile
fi

# host ip needed by application for better_errors whitelisting to work
export HOST_IP=`/sbin/ip route|awk '/default/ { print $3 }'`

exec "$@"
