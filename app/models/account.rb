class Account < ActiveRecord::Base
  belongs_to :human
  has_many :transactions
end
