class User < ActiveRecord::Base
  has_many :transactions
  has_many :emails
  has_one :credential
  has_many :whitelists
  has_one :profile
  has_one :reward
  has_many :phones
  has_many :user_emails
  has_many :ccards
  has_one :social_medium

  validates_uniqueness_of :email
end
