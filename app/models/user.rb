class User < ActiveRecord::Base
  has_many :transactions
  has_many :emails
  has_one :credential
  has_many :whitelists

  validates_uniqueness_of :email
end
