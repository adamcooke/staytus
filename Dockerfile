# This Dockerfile will create a container which can run the Staytus
# application. This is ideal for deploying Staytus into container environments.
# Some additional configuration is needed when running the application.

# NOTE: it does not install a database server so an external database
# server will need to be provided when running the application. You should
# set environment variables as needed to configure the application including
# DATABASE_URL.

FROM ruby:2.5

# Install Node.js
RUN apt-get update
RUN apt-get install nodejs default-mysql-client -y

# Create a user to run the application
RUN useradd -r -d /app -m -s /bin/bash app
USER app
WORKDIR /app

# Install bundler
RUN gem install bundler --no-doc
RUN bundle config --global frozen 1
RUN bundle config set build '--build-flags "-march=x86-64 -mtune=generic"'
RUN bundle config --local build.sassc --disable-march-tune-native

# Install gem dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Set environment
ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT 1

# This is the default DATABASE_URL which will almost certainly need
# to be overriden when the application runs.
ENV DATABASE_URL mysql2://staytus@127.0.0.1/staytus

# Copy the application (and set permissions)
COPY --chown=app . .

# Precompile assets
RUN bundle exec rake assets:precompile

# Set up the entrypoint
EXPOSE 8787
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
