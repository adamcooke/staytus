FROM ubuntu:16.04
LABEL maintainer="Nikita Rukavkov <nrukavkov@appulate.com>"

ARG STAYTUS_VERSION="stable"
ENV DEBIAN_FRONTEND="noninteractive" TZ="Etc/UTC" TINI_VERSION="v0.19.0"

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

RUN chmod +x /tini && \
    apt-get -q update && \
    apt-get -q install -y tzdata ruby ruby-dev ruby-json nodejs build-essential vim \
        libmysqlclient-dev mysql-client && \
    ln -fs "/usr/share/zoneinfo/${TZ}" /etc/localtime && \
    gem update --system && \
    gem install bundler:1.13.6 procodile json:1.8.3 && \
    mkdir -p /opt/staytus && \
    useradd -r -d /opt/staytus -m -s /bin/bash staytus && \
    chown staytus:staytus /opt/staytus && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --chown=staytus . /opt/staytus/staytus

RUN su - staytus -c "cd /opt/staytus/staytus ; bundle install --deployment --without development:test"

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

USER staytus

EXPOSE 8787

ENTRYPOINT ["/tini", "--", "/usr/local/bin/entrypoint.sh"]