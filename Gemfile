source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.4'
# Bootstrap with sass
gem 'bootstrap-will_paginate', '0.0.10'
gem 'bootstrap-sass',          '3.3.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.1'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]
# Coinbase gem
gem 'coinbase'
# Mailgun gem
gem 'mailgun-ruby', '~>1.0.3', require: 'mailgun'
# Mail gem
gem 'mail', '2.6.3'
# For cron tasks and stuff
gem 'whenever', require: false
# The Twilio client
gem 'twilio-ruby'
# The Stripe client
gem 'stripe', '~> 1.36', '>= 1.36.1'

gem 'rqrcode_png'
group :development, :test do
  gem 'sqlite3',     '1.3.11'
  gem 'byebug',      '8.2.2'
  gem 'spring',      '1.6.3'
end

group :test do
  gem 'minitest-reporters', '1.1.7'
  gem 'mini_backtrace',     '0.1.3'
  gem 'guard-minitest',     '2.4.4'
end

group :production do
  gem 'unicorn'
  gem 'pg',             '0.18.4'
  gem 'puma',           '2.16.0'
end
