class Email < ActiveRecord::Base
  has_one :recieved_amount
end