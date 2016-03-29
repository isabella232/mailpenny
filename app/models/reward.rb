class Reward < ActiveRecord::Base
  belongs_to :human
  validates :sms ,:numericality => { :greater_than => 0}
  validates :email ,:numericality => { :greater_than => 0}
end