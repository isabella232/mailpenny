# The data can then be loaded with rake db:seed
# (or created alongside the db with db:setup).

# The meta accounts to track money and stuff
Account.create(account_type: 'withdrawal')
Account.create(account_type: 'deposit')
Account.create(account_type: 'fee')
Account.create(account_type: 'escrow')

# To make developer lives easier, create a dummy user for development:
unless Rails.env == 'production'
  dummy = User.create(
    username: 'dummy',
    email: 'email@example.com',
    password: 'password',
    password_confirmation: 'password',
    confirmed_at: Time.zone.today
  )

  dummy.profile = Profile.new(
    name: 'Dummy User',
    bio: 'Dummies do what dummies can',
    work_company: 'Dummy Corp',
    work_title: 'Chief Dummy Officer',
    location: 'Dummisvilee',
    twitter_username: 'dumdumdumdu',
    rate: 1
  )
end
