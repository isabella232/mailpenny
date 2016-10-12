[![Travis](https://img.shields.io/travis/rust-lang/rust.svg?maxAge=2592000)]()
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://www.rubydoc.info/github/payloadtech/mailpenny/master/frames)

Mailpenny
=========

This is the entire codebase for the Mailpenny app. Mailpenny uses [Mailgun](http://mailgun.com) to send/receive email.

## Setup

Clone the repository, and then run:  

```
bundle install --without production
bundle exec rake db:setup
```

It's a good idea to run five consoles:

1. Server with `bundle exec rails server`
2. Guard with `bundle exec guard`
3. Rails console with `bundle exec rails console`
4. Yard server with `bundle exec yard server --reload`
5. A regular terminal for git and file manipulation

## Docs

Generate docs using the `yard` command, and they will be saved in `doc/`.

Run `yard server --reload` which generates a fresh docs from your code on refresh, to keep an
eye on your method docs.

## Tests

Run `guard` in a console to continuously test the app on every save.

## Production

Test with `bundle exec rake test` before deploying!

Mailpenny uses postgresql as the DB, and in production automatically loads from
the `DATABASE_URL` config var.

If using heroku, remember to run
`heroku run rake db:create && heroku run rake db:setup`
