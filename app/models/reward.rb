class Reward < ActiveRecord::Base
  belongs_to :human
  validates :sms ,:numericality => { :greater_than => 0}
  validates :email ,:numericality => { :greater_than_or_equal_to => 0}
end