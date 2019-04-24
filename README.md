# Staytus

Staytus is a complete solution for publishing the latest information about
any issues with your web applications, networks or services. Along with
absolutely beautiful public & admin interfaces, Staytus is a powerful tool for
any organization with customers that rely on them to be online 24/7.

* [Check out the live demo](http://demo.staytus.co)
* [Read the roadmap](https://github.com/adamcooke/staytus/blob/master/ROADMAP.md)
* [Report a bug](https://github.com/adamcooke/staytus/issues/new?labels=bug)
* [Ask a question](https://github.com/adamcooke/staytus/issues/new?labels=question)

![Screenshot](https://s.adamcooke.io/15/iOzvtk.png)

## Installation from source

### System Requirements

* Ruby 2.1 or greater
* RubyGems and Bundler
* A MySQL database server

### Instructions

Before start, you'll need to create a new MySQL database:

```text
mysql$ CREATE DATABASE `staytus` CHARSET utf8 COLLATE utf8_unicode_ci;
mysql$ GRANT ALL ON staytus.* TO `staytus`@`localhost` IDENTIFIED BY "a_secure_password";
```

```text
$ git clone https://github.com/adamcooke/staytus
$ cd staytus
$ git checkout stable
$ bundle install --deployment --without development:test
$ cp config/database.example.yml config/database.yml
$ nano -w config/database.yml # Add your database configuration
$ bundle exec rake staytus:build staytus:install
$ bundle exec foreman start
```

This will run the application on HTTP port 5000. When you first
login, you'll be able to add your own site settings. Browse to http://[IP]:5000
to begin.

You may also want to change the SMTP configuration via environment variables,
which are described in [`config/environment.example.yml`](config/environment.example.yml).

### Upgrading

Once you've installed Staytus, you can easily upgrade it by
following this process.

```text
$ cd path/to/staytus
$ git pull origin stable
$ bundle
$ bundle exec rake staytus:build staytus:upgrade
```

Once you've done this, you should ensure you restart any Staytus
processes which you have running.

## E-Mail Notifications

All e-mail notifications are sent through a background worker process. This will be started automatically when you run the application using `foreman start`. If you don't do this, you can run jobs using `bundle exec rake jobs:work`.

## Administration

To log in for the first time, visit the `/admin`, and log in with email
`admin@example.com` and password `password`. You will probably want to go to
Settings -> Users and set up your admins.

## Themes

All themes are stored in the `content/themes` directory. You can
add your own themes in this directory but we do not recommend
making changes to the `default` theme as these changes may get
overridden in an upgrade.

Full details about how to make these will be coming soon.

## Examples in the wild

* [Viaduct Status Site](http://status.viaduct.io)
* [Dial 9 Status Site](http://status.dial9.co.uk)

If you're running Staytus in the wild, let us know so we can
add you to the list.

## Screenshots

Here's a few extra screenshots from the admin and public interfaces.

![Screenshot](https://s.adamcooke.io/15/SZ2WUI.png)

![Screenshot](https://s.adamcooke.io/15/TgqeV8.png)

![Screenshot](https://s.adamcooke.io/15/JErXE75Fhu.png)

![Screenshot](https://s.adamcooke.io/15/fb5kFe.png)

![Screenshot](https://s.adamcooke.io/15/9n5W4j.png)
