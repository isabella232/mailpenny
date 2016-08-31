Mailpenny
=========

This is the entire codebase for the Mailpenny app. Mailpenny uses [Mailgun](http://mailgun.com) to send/recieve email, and [Coinbase](http://coinbase.com) to store bitcoin.

## Setup

Clone the repository, and then run:  

```
bundle install --without production
bundle exec rake db:setup
```

It's a good idea to run four consoles:

1. Server with `bundle exec rails server`
2. Guard with `bundle exec guard`
3. Rails console with `bundle exec rails console`
4. A regular terminal for git and file manipulation

## Docs

Documentation is generated using the `yard` command, and is saved in `doc/`

## Tests

Run `guard` in a console to continuously test the app on every save.

## Production

Test with `bundle exec rake test` before deploying!

Mailpenny uses postgresql as the DB, and in production automatically loads from
the `DATABASE_URL` config var.

If using heroku, remember to run
`heroku run rake db:create && heroku run rake db:setup`
