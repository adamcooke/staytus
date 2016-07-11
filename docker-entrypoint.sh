#!/bin/bash

if [ ! -z "$DEBUG" ]; then
    set -xe
fi

# Database settings
DB_ADAPTER="${DB_ADAPTER:-mysql2}"
DB_POOL="${DB_POOL:-5}"
DB_HOST="${DB_HOST:-127.0.0.1}"
DB_PORT="${DB_PORT:-3306}"
DB_USER="${DB_USER:-staytus}"
DB_PASSWORD="${DB_PASSWORD:-}"
DB_PASS="${DB_PASS:-$(echo "$DB_PASSWORD")}"
DB_DATABASE="${DB_DATABASE:-staytus}"

SPECIAL_SETTING_DETECTION_MODE="${SPECIAL_SETTING_DETECTION_MODE:-False}"

# Default settings that need to be set
SETTING_STAYTUS_THEME="${SETTING_STAYTUS_THEME:-default}"
SETTING_STAYTUS_DEMO="${SETTING_STAYTUS_DEMO:-0}"

CONFIG_FILE="/opt/staytus/config/environment.yml"

prepareFiles() {
    mv -f /opt/staytus/config/database.example.yml /opt/staytus/config/database.yml
    mv -f /opt/staytus/config/environment.example.yml /opt/staytus/config/environment.yml
}
prepareDatabase() {
    local TIMEOUT=60
    echo "Waiting for database server to allow connections ..."
    while ! mysqladmin ping -h"$DB_HOST" -P "$DB_PORT" -u "$DB_USER" --password="$DB_PASS" --silent >/dev/null 2>&1
    do
        TIMEOUT=$(expr $TIMEOUT - 1)
        if [[ $TIMEOUT -eq 0 ]]; then
            echo "Could not connect to database server. Exiting."
            exit 1
        fi
        echo -n "."
        sleep 1
    done
    echo "CREATE DATABASE $DB_DATABASE CHARSET utf8 COLLATE utf8_unicode_ci;" | mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" || true
    echo "Staytus database prepared."
}
configureDatabaseSettings() {
    sed -i "s/adapter:.*/adapter: \"$DB_ADAPTER\"/" /opt/staytus/config/database.yml
    sed -i "s|pool:.*|pool: $DB_POOL|" /opt/staytus/config/database.yml
    sed -i "s|host:.*|host: \"$DB_HOST\"|" /opt/staytus/config/database.yml
    sed -i "s/username:.*/username: \"$DB_USER\"/" /opt/staytus/config/database.yml
    sed -i "s|password:.*|password: \"$DB_PASSWORD\"|" /opt/staytus/config/database.yml
    sed -i "s|database:.*|database: $DB_DATABASE|" /opt/staytus/config/database.yml
    echo "Staytus database settings set."
}
configureSettings() {
    echo "Executing Staytus configuration ..."
    local given_settings=($(env | sed -n -r "s/SETTING_([0-9A-Za-z_]*).*/\1/p"))
    # If staytus should ever get more than "one" config files, change this
    local file="$CONFIG_FILE"
    for setting_key in "${given_settings[@]}"; do
        local key="SETTING_$setting_key"
        local setting_var="${!key}"
        local type="string"
        if [ -z "$setting_var" ]; then
            echo "Empty var for key \"$setting_key\"."
            continue
        fi
        if [ ! -z "$SPECIAL_SETTING_DETECTION_MODE" ] && ([ "$SPECIAL_SETTING_DETECTION_MODE" = "True" ] || [ "$SPECIAL_SETTING_DETECTION_MODE" = "true" ]); then
            type=""
        fi
        echo "$setting_key: \"$setting_var\"" >> "$file"
    done
    unset setting_key setting_var KEY
    if [ ! -z "$STAYTUS_CUSTOM_SETTINGS" ]; then
        echo -e "\n$STAYTUS_CUSTOM_SETTINGS" >> "$CONFIG_FILE"
    fi
    echo "Staytus configuration succeeded."
}
runStaytus() {
    cd /opt/staytus || exit 1
    bundle exec rake staytus:build staytus:upgrade
    # Fix the Gemfile because https://github.com/bundler/bundler/issues/4576
    sed -i 's/\.\.\/\.\.\/Gemfile/Gemfile/g' /opt/staytus/bin/bundle
    exec -- bundle exec foreman start
}

prepareFiles
prepareDatabase
configureDatabaseSettings
configureSettings
runStaytus
