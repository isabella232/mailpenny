# The data can then be loaded with rake db:seed
# (or created alongside the db with db:setup).

# The meta accounts to track money and stuff
Account.create(meta: true, meta_name: 'withdrawal')
Account.create(meta: true, meta_name: 'deposit')
Account.create(meta: true, meta_name: 'revenue')
