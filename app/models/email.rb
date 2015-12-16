class Email < ActiveRecord::Base
  has_one :transactions
  belongs_to :user
end