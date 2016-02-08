class User < ActiveRecord::Base
  has_many :transactions
  has_many :emails
  has_one :credential
end
