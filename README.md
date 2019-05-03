# Staytus

This project is a fork of Adam Cooke's [Staytus app](https://github.com/adamcooke/staytus/).

Staytus is a complete solution for publishing the latest information about
any issues with your web applications, networks or services. Along with
absolutely beautiful public & admin interfaces, Staytus is a powerful tool for
any organisation with customers that rely on them to be online 24/7.

* [Check out the live demo](http://demo.staytus.co)
* [Report a bug](https://github.com/juliancheal/staytus/issues/new?labels=bug)
* [Ask a question](https://github.com/juliancheal/staytus/issues/new?labels=question)
* [Installation tutorial](https://atech.blog/atech/install-staytus-tutorial)

![Screenshot](https://s.adamcooke.io/15/iOzvtk.png)

### System Requirements

* Ruby 2.3 or greater
* RubyGems and Bundler
* A Postgres database server
* Bundler (`gem install bundler`)
* Procodile (`gem install procodile`)

## E-Mail Notifications

All e-mail notifications are sent through a background worker process. This will be started automatically when you run the application using `foreman start`. If you don't do this, you can run jobs using `bundle exec rake jobs:work`.

## Administration

To log in for the first time, visit the `/admin`, and log in with email
`admin@example.com` and password `smartvm`. You will probably want to go to
Settings -> Users and set up your admins.

## Themes

All themes are stored in the `content/themes` directory. You can
add your own themes in this directory but we do not recommend
making changes to the `default` theme as these changes may get
overridden in an upgrade.
