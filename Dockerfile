FROM ruby
MAINTAINER Tim Perry <pimterry@gmail.com>

USER root

RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    # Set password to temp-password - reset to random password on startup
    echo mysql-server mysql-server/root_password password temp-password | debconf-set-selections && \
    echo mysql-server mysql-server/root_password_again password temp-password | debconf-set-selections && \   
    # Instal MySQL for data, node as the JS engine for uglifier
    apt-get install -y mysql-server nodejs
    
COPY . /opt/staytus

RUN cd /opt/staytus && \
    bundle install --deployment --without development:test

ENTRYPOINT /opt/staytus/docker-start.sh

# Persists all DB state
VOLUME /var/lib/mysql

# Persists copies of other relevant files (DB config, custom themes). Contents of this are copied 
# to the relevant places each time the container is started
VOLUME /opt/staytus/persisted

EXPOSE 5000
