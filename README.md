# Staytus

Staytus is a complete solution for publishing the latest information about
any issues with your web applications, networks or services. Along with
absolutely beautiful public & admin interfaces, Staytus is a powerful tool for
any organization with customers rely on them to be online 24/7.

![Screenshot](https://s.adamcooke.io/15/vGMNR1.png)

## System Requirements

* Ruby 2.1 or greater
* RubyGems and Bundler
* A MySQL database server

## Installation

Installing Staytus is easy and will only take a few moments. Don't forget,
you need your status site to be available when you're other infrastructure is
unavailable so why not deploy offsite using [Viaduct's](http://viaduct.io)
free application hosting platform?

```text
$ git clone https://github.com/adamcooke/staytus
$ git checkout stable
$ cd staytus
$ bundle install --deployment --without deployment:test
$ cp config/database.example.yml config/database.yml
$ nano -w config/database.yml # Add your database configuration
$ bundle exec rake db:create db:schema:load
$ bundle exec rails server -b 0.0.0.0 -p 8787
```

This will run the application on HTTP port 8787. When you first
login, you'll be able to add your own site settings. Browse to http://[IP]:8787
to begin.

## Upgrading

Once you've installed Staytus, you can easily upgrade it by
following this process.

```text
$ cd path/to/staytus
$ git pull origin stable
$ bundle
$ bundle exec rake staytus:upgrade
```

Once you've done this, you should ensure you restart any Staytus
processes which you have running.
