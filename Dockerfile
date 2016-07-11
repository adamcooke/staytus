FROM ruby:2.3.1
MAINTAINER Tim Perry <pimterry@gmail.com>

USER root

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y nodejs mysql-client && \
    gem update --system 2.6.1 && \
    gem install bundler

COPY . /opt/staytus

RUN mv /opt/staytus/docker-entrypoint.sh /entrypoint.sh && \
    cd /opt/staytus && \
    bundle install --deployment --without development:test && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT "/entrypoint.sh"

EXPOSE 5000
