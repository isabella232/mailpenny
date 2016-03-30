class Reward < ActiveRecord::Base
  belongs_to :human
  after_initialize :init

  def init
    self.sms = 1
    self.email = 1
  end

  validates :sms ,:numericality => { :greater_than => 0}
  validates :email ,:numericality => { :greater_than_or_equal_to => 0}
end