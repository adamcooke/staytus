FROM ruby
MAINTAINER Tim Perry <pimterry@gmail.com>

USER root
ENV HOME /opt/staytus
WORKDIR $HOME

RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    # Set password to temp-password - reset to random password on startup
    echo mysql-server mysql-server/root_password password temp-password | debconf-set-selections && \
    echo mysql-server mysql-server/root_password_again password temp-password | debconf-set-selections && \
    # Instal MySQL for data, node as the JS engine for uglifier
    apt-get install -y mysql-server nodejs

ADD Gemfile* $HOME/
ADD Gemfile.lock $HOME/

RUN bundle install --deployment --without development:test

COPY . $HOME

RUN cp config/database.example.yml config/database.yml
RUN cp config/environment.example.yml config/environment.yml

RUN bundle exec rake assets:clobber assets:precompile

# Default command
CMD ["bundle","exec","foreman", "start"]


EXPOSE 5000
