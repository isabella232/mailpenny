require 'authy'

Authy.api_key = ENV['AUTHY_API_KEY']
Authy.api_uri = ENV['AUTHY_API_KEY'] || 'https://api.authy.com/'
