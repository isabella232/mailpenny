require 'authy'

Authy.api_key = Figaro.env.authy_key
Authy.api_uri = 'https://api.authy.com/'
