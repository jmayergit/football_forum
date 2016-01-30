# Setup Development

1. Fork respo
2. bundle install
3. bin/rake db:create db:migrate

## Avatar

These instructions are for an AWS S3 account, however almost any cloud storage
service is supported by FOG

1. Create AWS S3 account
2. Create an S3 bucket -note problems may arise if bucket name contains
dots or is identical to domain name
3. Create .env file in root directory
4. Set the following:
    ENV['S3_BUCKET_NAME']
    ENV['REGION']
    ENV['AWS_SECRET_ACCESS_KEY']
    ENV['AWS_ACCESS_KEY_ID']
    ENV['CARRIERWAVE_DEFAULT_URL']

## Mail


* In development use the mailcatcher gem to intercept transactional emails
* Do not bundle the gem

# Setup Production

After creating a heroku some ENV variables need to be set before creating database

## Avatar

~ Same as in production ~

## Mail

1. Add heroku [Doucumentatino](https://elements.heroku.com/addons/mailgun)
2. Set SMTP variables
    ENV['MAILGUN_SMTP_PORT']
    ENV['MAILGUN_SMTP_SERVER']
    ENV['MAILGUN_SMTP_LOGIN']
    ENV['MAILGUN_SMTP_PASSWORD']
4. Set host and domain configs
```ruby
# /config/environments/production
config.action_mailer.default_url_options = { host: "www.yourdomain.com" }

config.action_mailer.smtp_settings = {
  ...
  domain:          'yourdomain.com',
  ...
}
```
5. Set devise mailer_sender domain
```ruby
# /config/initializers/devise
config.mailer_sender = 'yourdomain.com'
```

# Configuration

## will_paginate

Define posts per page.
```ruby
# /app/models/post.rb
class Post < ActiveRecord::Base
  ...
  self.per_page = 5
  ..
end
```

Define topics per page.
```ruby
# /app/models/topic.rb
class Topic < ActiveRecord::Base
  ...
  self.per_page = 5
  ...
end
```

# App Usage

Once deployed you will want to create and Admin account for yourself. These
are non-registerable and will have to be created manually from a database connection.

### What Admin can do

1. CRUD Forum
2. Control User Status
3. Create User Membership

### What User can do

1. Create Topic
2. Create Post
3. Vote on Post
4. Create Bookmark
5. Upload Avatar
6. Format Post via markdown

### What Moderator can do (in addition to what User can do)

1. Sticky Topic
2. Lock Topic

Admins cannot create topics or posts. If you wish to edit the body of
another users' post, that violates decorum, you must manually do it from the database.
If you wish to create topics or posts you must register a user account.
