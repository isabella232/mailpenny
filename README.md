Mailman
=======

This is the entire codebase for the Mailman app. Mailman uses [Mailgun](http://mailgun.com) to send/recieve email, and [Coinbase](http://coinbase.com) to store bitcoin.

## Setup

Clone the repository, and then run:  
```
bundle install --without production
bundle exec rake db:create
bundle exec rake db:migrate
```

It's a good idea to run four consoles:
  1. Server with `bundle exec rails server`
  2. Guard with `bundle exec guard`
  3. Rails console with 'bundle exec rails console'
  4. A regular terminal for git and file manipulation

## Tests

Run `guard` in a console to run minitests everytime you modify tested files.
Make sure everything is tested.

## Production

Test with `bundle exec rake test` before deploying!

Mailman uses postgres as production DB, automatically loaded from
the `DATABASE_URL` config var.

If using heroku, remember to run
`heroku run rake db:create && heroku run rake db:migrate`
