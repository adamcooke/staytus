FROM manageiq/ruby:latest

RUN yum -y install centos-release-scl-rh && \
    yum -y install --setopt=tsflags=nodocs \
                   # To compile native gem extensions
                   gcc-c++ \
                   # For git based gems
                   git \
                   # For checking service status
                   nmap-ncat \
                   # To compile pg gem
                   rh-postgresql10-postgresql-devel \
                   rh-postgresql10-postgresql-libs \
                   nodejs \
                   && \
    yum clean all

ENV WORKDIR /opt/staytus
ENV RAILS_ROOT $WORKDIR
WORKDIR $WORKDIR

COPY Gemfile $WORKDIR

RUN source /opt/rh/rh-postgresql10/enable && \
    echo "gem: --no-document" > ~/.gemrc && \
    gem install bundler --conservative --without development:test && \
    bundle install --jobs 8 --retry 3 && \
    find ${RUBY_GEMS_ROOT}/gems/ | grep "\.s\?o$" | xargs rm -rvf && \
    rm -rvf ${RUBY_GEMS_ROOT}/cache/* && \
    rm -rvf /root/.bundle/cache

COPY . $WORKDIR

RUN chgrp -R 0 $WORKDIR && \
    chmod -R g=u $WORKDIR

EXPOSE 8787

ENV RAILS_ENV production
# Set a value even if we don't use it so active record doesn't blow up
ENV DATABASE_URL postgresql://localhost:5432/postgres

ENTRYPOINT ["bundle", "exec", "rails", "server"]
