FROM ruby:2.6.3-alpine

RUN apk add --update --no-cache \
  build-base \
  mariadb-dev \
  tzdata \
  nodejs \
  libc6-compat

RUN adduser -D staytus
WORKDIR /staytus
COPY Gemfile* ./
COPY config/database.example.yml config/database.yml
RUN bundle install --binstubs --without development test
COPY --chown=staytus . .

ARG DATABASE_URL
ENV RAILS_LOG_TO_STDOUT=TRUE
RUN bundle exec rake staytus:build
RUN chown -R staytus:staytus /staytus
USER staytus

EXPOSE 5000

ENTRYPOINT ["./docker-up.sh"]
