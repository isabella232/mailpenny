# User phone numbers
class PhoneNumber < ActiveRecord::Base
  belongs_to :user
end
