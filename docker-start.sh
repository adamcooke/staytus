#!/bin/bash
/etc/init.d/mysql start
cd /opt/staytus

# Enable SMTP via environment variable
STAYTUS_SMTP_ENABLED=${STAYTUS_SMTP_ENABLED:-false}

# Set environment variables
if [ "$STAYTUS_SMTP_ENABLED" = true ]; then
cat << EOF > /opt/staytus/config/environment.yml
STAYTUS_THEME: '${STAYTUS_THEME:-default}'
STAYTUS_DEMO: '${STAYTUS_DEMO:-0}'

STAYTUS_SMTP_HOSTNAME: ${STAYTUS_SMTP_HOSTNAME:-smtp.deliverhq.com}
STAYTUS_SMTP_USERNAME: ${STAYTUS_SMTP_USERNAME:-username}
STAYTUS_SMTP_PASSWORD: ${STAYTUS_SMTP_PASSWORD:-password}
EOF
else
cat << EOF > /opt/staytus/config/environment.yml
STAYTUS_THEME: '${STAYTUS_THEME:-default}'
STAYTUS_DEMO: '${STAYTUS_DEMO:-0}'
EOF
fi

# Configure DB with random password, if not already configured
if [ ! -f /opt/staytus/persisted/config/database.yml ]; then
  export RANDOM_PASSWORD=`openssl rand -base64 32`

  mysqladmin -u root -ptemp-password password $RANDOM_PASSWORD
  echo "CREATE DATABASE staytus CHARSET utf8 COLLATE utf8_unicode_ci" | mysql -u root -p$RANDOM_PASSWORD

  cp config/database.example.yml config/database.yml
  sed -i "s/username:.*/username: root/" config/database.yml
  sed -i "s|password:.*|password: $RANDOM_PASSWORD|" config/database.yml

  # Copy the config to persist it, and later copy back on each start, to persist this config file 
  # without persisting all of /config (which is mostly app code)
  mkdir /opt/staytus/persisted/config
  cp config/database.yml /opt/staytus/persisted/config/database.yml

  bundle exec rake staytus:build staytus:install
else
  # Use the previously saved config from the persisted volume
  cp /opt/staytus/persisted/config/database.yml config/database.yml
  # TODO also copy themes back and forth too

  # If already configured, check if there are any migrations to run
  bundle exec rake staytus:build staytus:upgrade
fi

bundle exec foreman start
