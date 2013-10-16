Pull Request Notifier
=====================

You want to follow some pull requests and get notified when they are merged? Here is a GitHub Pull Request Notifier!

* Sign in with your GitHub account
* Paste the URL of the pull request you want to follow
* Get a daily mail with a list of the pull requests that have been merged

A sample Rails app
------------------

This is a sample Rails app for the [Gemnasium workshop](http://www.dotrb.eu/workshops#gemnasium) at [dotRB2013](http://www.dotrb.eu/).

Warning! This app has been written for the workshop and is not production-ready!

Requirements
------------

The app is known to work with:

* ruby 1.9.1
* bundler 1.3.5
* postgresql 9.1
* redis 2.2

Here are the packages you need to make it run on ubuntu 12.04 "precise":

```
apt-get install ruby1.9.1 \
  ruby1.9.1-dev build-essential \
  libpq-dev libv8-dev libsqlite3-dev \
  postgresql-9.1 postgresql-contrib-9.1 postgresql-client-9.1 \
  redis-server
```

Install
-------

1. clone this project
1. run `bundle install`
1. setup the database
1. configure the mailer
1. export GitHub client credentials
1. run the `./start` script

`ActionMailer` is used to send emails to the users, so you may have to set `config.action_mailer` in your `config/environments/development.rb` and `config/environments/production.rb` config files.

Go to [gemnasium/dotrb2013-docker](https://github.com/gemnasium/dotrb2013-docker) if you want to install with [docker](http://docker.io).

GitHub application
------------------

You need credentials for your GitHub client:

1. go to the [GitHub applications settings](https://github.com/settings/applications)
1. register your application
1. export your credentials

Export your credentials:

```
GITHUB_CLIENT_ID="1337"
GITHUB_CLIENT_SECRET="secret"

export GITHUB_CLIENT_ID
export GITHUB_CLIENT_SECRET

rails server
```

The app also looks for a `.env` file when running in development environment.

Usage
-----

Normal user

1. visit the root URL
1. sign in using GitHub
1. manage your subscriptions

There is no sign up: user account is automatically created from GitHub account.

Admin interface

* `/admin` for activeadmin
* `/admin/resque` for resque-web

Default admin user

* login is `admin@example.com`
* password is `password`

How it works
------------

Data model:

* User: a normal user, comes from GitHub
* PullRequest - mirrors GitHub Pull Request object
* Subscription - relation b/w a user and a pull request she watches
* Notification - relation b/w a merged pull request and a user that will be notified about it
* AdminUser - to access the admin interface only, not bound to GitHub, works with the devise gem

Resque elementary jobs:

* connect to GitHub and fetch pull request metadata: title, body, etc.
* connect to GitHub and update the "merged" status
* notify one user about the pull requests that have been merged

Resque scheduled jobs (every day):

* update all the open pull requests
* notify all the users

Licence
-------

MIT Licence.

