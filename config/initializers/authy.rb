require 'authy'

Authy.api_key = ENV['AUTHY_API_KEY']

if Rails.env == 'production'
  Authy.api_uri = 'https://api.authy.com/'
else
  Authy.api_uri = 'http://sandbox-api.authy.com/'
end
