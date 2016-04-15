source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.4'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.1'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 2.5', '>= 2.5.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]
# Mailgun gem
gem 'mailgun-ruby', '~>1.0.3', require: 'mailgun'
# Mail gem
gem 'mail', '2.6.3'
# The Twilio client
gem 'twilio-ruby', '~> 4.11', '>= 4.11.1'
# The Stripe client
gem 'stripe', '~> 1.36', '>= 1.36.1'
# JSON library
gem 'json', '~> 1.8', '>= 1.8.3'
# QR code generator
gem 'rqrcode_png', '~> 0.1.5'
# Make authentication simple with devise!
gem 'devise', '~> 3.5', '>= 3.5.6'
# Twitter gem for tweets
gem 'twitter', '~> 5.11.0'
# Figaro for configuration secrets
gem 'figaro', '~> 1.1', '>= 1.1.1'

group :development, :test do
  gem 'sqlite3',     '1.3.11'
  gem 'byebug',      '8.2.2'
  gem 'spring',      '1.6.3'
  gem 'guard',       '~> 2.13'
end

group :test do
  gem 'minitest-reporters', '1.1.7'
  gem 'mini_backtrace',     '0.1.3'
  gem 'guard-minitest',     '2.4.4'
end

group :production do
  gem 'unicorn', '~> 5.1'
  gem 'pg',             '0.18.4'
  gem 'puma',           '2.16.0'
  gem 'rails_12factor', '~> 0.0.3'
end
