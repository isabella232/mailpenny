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
# The Authy client
gem 'authy', '~> 2.6', '>= 2.6.2'
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
  gem 'guard-livereload', '~> 2.5', '>= 2.5.2'
  gem 'faker', '~> 1.6', '>= 1.6.3'
  gem 'rspec-rails', '~> 3.4', '>= 3.4.2'
  gem 'factory_girl_rails', '~> 4.7'
  gem 'capybara', '~> 2.7'
  gem 'guard-rspec', '~> 4.6', '>= 4.6.5'
end

group :test do
  gem 'database_cleaner', '~> 1.5', '>= 1.5.2'
  gem 'simplecov', '~> 0.11.2'
end

group :production, :staging do
  gem 'unicorn', '~> 5.1'
  gem 'pg',             '0.18.4'
  gem 'puma',           '2.16.0'
  gem 'rails_12factor', '~> 0.0.3'
end
