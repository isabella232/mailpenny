require 'authy'

Authy.api_key = Figaro.env.authy_key
Authy.api_uri = Figaro.env.authy_url
