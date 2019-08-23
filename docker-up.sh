#!/bin/sh

bundle exec rake staytus:install staytus:upgrade
bundle exec foreman start
