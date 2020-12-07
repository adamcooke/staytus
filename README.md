**Where did the GitHub Issues go?** Due to a bit of neglect on my part and an abundance of support questions coming to this repository as GitHub issues I have taken the decision to close all issues. I don't have time to go through each issue individually. If your issue has been closed and it's not a support request and you still think it is relevant, please comment and I'll review. 

**Future plans** I'm hoping to do a bit more work on Staytus soon. One of the main things I want to achieve will be to provide Staytus as a container rather than requiring people to install it manually on servers which seems to be cause of a number of issues. Once this is complete, I'll update all docs to make it clear now to deploy Staytus either using Docker or onto a Kubernetes cluster if that's what you prefer.

# Staytus

Staytus is a complete solution for publishing the latest information about
any issues with your web applications, networks or services. Along with
absolutely beautiful public & admin interfaces, Staytus is a powerful tool for
any organization with customers that rely on them to be online 24/7.

* [Check out the live demo](http://demo.staytus.co)
* [Read the roadmap](https://github.com/adamcooke/staytus/blob/master/ROADMAP.md)
* [Report a bug](https://github.com/adamcooke/staytus/issues/new?labels=bug)
* [Ask a question](https://github.com/adamcooke/staytus/issues/new?labels=question)
* [Installation tutorial](https://atech.blog/atech/install-staytus-tutorial)
* **[Donate to fund continued development](http://monzo.me/adamcooke)**

![Screenshot](https://s.adamcooke.io/15/iOzvtk.png)

## Installation from source

### System Requirements

* Ruby 2.3 or greater (including `ruby-dev` package on Linux)
* RubyGems and Bundler
* A MySQL database server
* Bundler (`gem install bundler`)
* Rake (`gem install rake`)
* Procodile (`gem install procodile`)

### Installation Instructions

**A comprehensive tutorial about how to install Staytus [available here](https://atech.blog/atech/install-staytus-tutorial) on the [aTech Media blog](https://atech.blog).**

Alternativly, these basic instructions will get you up and running:

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
$ procodile start --foreground
```

In case the `bundle install` command fails at `mysql2`, make sure that you have the MySQL development package (ie. `mysql` on macOS, `libmariadb-dev` for MariaDB on Linux)

This will run the application on HTTP port 5000. When you first
login, you'll be able to add your own site settings. Browse to http://[IP]:8787
to begin.

You may also want to change the SMTP configuration via environment variables,
which are described in [`config/environment.example.yml`](config/environment.example.yml).

To run staytus in the background, simply run `procodile start` without the `--foreground` option.

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

## Examples in the wild

* [aTech Status Site](https://status.atechmedia.com)
* [Dial 9 Status Site](https://status.dial9.co.uk)

If you're running Staytus in the wild, let us know so we can
add you to the list.

## Screenshots

Here's a few extra screenshots from the admin and public interfaces.

![Screenshot](https://s.adamcooke.io/15/SZ2WUI.png)

![Screenshot](https://s.adamcooke.io/15/TgqeV8.png)

![Screenshot](https://s.adamcooke.io/15/JErXE75Fhu.png)

![Screenshot](https://s.adamcooke.io/15/fb5kFe.png)

![Screenshot](https://s.adamcooke.io/15/9n5W4j.png)
