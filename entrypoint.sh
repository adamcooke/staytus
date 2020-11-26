#!/bin/bash
AUTO_CONF="${AUTO_CONF:-true}"
DB_ADAPTER="${DB_ADAPTER:-mysql2}"
DB_POOL="${DB_POOL:-5}"
DB_HOST="${DB_HOST:-database}"
DB_USER="${DB_USER:-staytus}"
DB_PASSWORD="${DB_PASSWORD:-staytus}"
DB_DATABASE="${DB_DATABASE:-staytus}"

cd /opt/staytus/staytus || { echo "staytus directory not found."; exit 1; }

if [ "$AUTO_CONF" = "true" ] ; then
    
    if [ ! -f "/opt/staytus/staytus/config/database.yml" ]; then
        cp -f /opt/staytus/staytus/config/database.example.yml /opt/staytus/staytus/config/database.yml
    fi

    echo "CREATE DATABASE staytus CHARSET utf8 COLLATE utf8_unicode_ci;" | mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" || { echo "=> Issues creating database staytus, can be ignored when the database already exists."; true; }

    sed -i "s|adapter:.*|adapter: \"$DB_ADAPTER\"|" /opt/staytus/staytus/config/database.yml
    sed -i "s|pool:.*|pool: $DB_POOL|" /opt/staytus/staytus/config/database.yml
    sed -i "s|host:.*|host: \"$DB_HOST\"|" /opt/staytus/staytus/config/database.yml
    sed -i "s|username:.*|username: \"$DB_USER\"|" /opt/staytus/staytus/config/database.yml
    sed -i "s|password:.*|password: \"$DB_PASSWORD\"|" /opt/staytus/staytus/config/database.yml
    sed -i "s|database:.*|database: \"$DB_DATABASE\"|" /opt/staytus/staytus/config/database.yml
fi

set -ex
bundle exec rake staytus:build staytus:upgrade

exec procodile start -f