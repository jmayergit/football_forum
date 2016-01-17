== README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version - 2.0.0

* System dependencies

* Configuration

In development use mailcatcher gem to intercept emails and install the gem
from your terminal, that is, use this command:

bundle gem install mailcatcher

but do not, according to the gem's developer, place it in your gemfile.

the Gemfile will likely require rake 10.4.2, if you have activated a more
recent version, prepend bundle exec to execute a script in the context of
your current bundle, i.e. rake 10.4.2

## Required Configuration

#### mailgun smtp settings

Domain and host parameters should reflect your url.

```ruby
# /config/environments/production
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
```

#### devise mailer

Configure the email address which will be shown in Devise::Mailer.

```ruby
# /config/initializers/devise
config.mailer_sender = 'yourdomain.com'
```

## Optional Configuration

#### will_paginate

Define how many posts you would like per page.

```ruby
# /app/models/post.rb
class Post < ActiveRecord::Base
  ...
  self.per_page = 5
  ..
end
```

Define how many topics you would like per page.

```ruby
# /app/models/topic.rb
class Topic < ActiveRecord::Base
  ...
  self.per_page = 5
  ...
end
```

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

Once deployed you will want to create and Admin account for yourself. To
protect against just ANYONE signing up for an Admin account I have left out
the registerable module for Admin, meaning you will have to manually create
from a database connection. Using Heroku? - heroku console

Admins cannot create topics or posts. If you wish to edit the body of
another users' post, that violates decorum, you must manually do it from the database.
If you wish to create topics or posts you must register a user account.
* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
