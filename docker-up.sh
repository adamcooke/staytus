#!/bin/sh

# copy and update database.yml
cp config/database.example.yml config/database.yml

# set defaults for ENV vars
export DB_HOST="${DB_HOST:-127.0.0.1}"
export DB_DATABASE="${DB_DATABASE:-staytus}"
export DB_USER="${DB_USER:-staytus}"
export DB_PASSWORD="${DB_PASSWORD:-staytus}"

sed -i "s|host:.*|host: <%= ENV['DB_HOST'] %>|" config/database.yml
sed -i "s|username:.*|username: <%= ENV['DB_USER'] %>|" config/database.yml
sed -i "s|password:.*|password: <%= ENV['DB_PASSWORD'] %>|" config/database.yml
sed -i "s|database:.*|database: <%= ENV['DB_DATABASE'] %>|" config/database.yml

bundle exec rake staytus:install staytus:upgrade
bundle exec foreman start
