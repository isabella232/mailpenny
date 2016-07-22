# The data can then be loaded with rake db:seed
# (or created alongside the db with db:setup).

# The meta accounts to track money and stuff
# Account.create(meta: true, meta_name: 'withdrawal')
# Account.create(meta: true, meta_name: 'deposit')
# Account.create(meta: true, meta_name: 'revenue')

# To make developer lives easier, create a dummy user for development:
unless Rails.env == 'production'
  User.create(
    username: 'dummy',
    email: 'email@example.com',
    password: 'password',
    password_confirmation: 'password',
    confirmed_at: Time.zone.today
  )
end
