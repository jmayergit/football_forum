== README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version - 2.0.0

* System dependencies

* Configuration

## SMTP Settings

#### mailgun

Change domain and host parameter to whatever your domain is

--> /config/environments/production
config.action_mailer.default_url_options = { host: "www.yourdomain.com" }

config.action_mailer.smtp_settings = {
  port:            ENV['MAILGUN_SMTP_PORT'],
  address:         ENV['MAILGUN_SMTP_SERVER'],
  user_name:       ENV['MAILGUN_SMTP_LOGIN'],
  password:        ENV['MAILGUN_SMTP_PASSWORD'],
  domain:          'yourdomain.com',
  authentication:  :plain
}

config.action_mailer.delivery_method = :smtp
<---

## Devise

#### Mailer
Configure the email address which will be shown in Devise::Mailer

--> /config/initializers/devise
  config.mailer_sender = 'yourdomain.com'
<--

## will_paginate

Define how many posts you want per page

--> /app/models/post.rb
class Post < ActiveRecord::Base
  ...
  self.per_page = 5
  ..
end
<--

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

Once deployed you will want to create and Admin account for yourself. To
protect against just ANYONE signing up for an Admin account I have left out
the registerable module for Admin, meaning you will have to ssh into heroku
to manually create you account.

Admins cannot create topics or posts. If you wish to edit the body of
another users' post, that violates decorum, you must manually do it from the database.
If you wish to create topics or posts you must register a user account.
* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
