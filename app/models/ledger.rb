# The ledger that keeps tracking of internal transactions
class Ledger < ActiveRecord::Base
  belongs_to :from, :class_name => 'User', :foreign_key => :from_id
  belongs_to :to, :class_name => 'User', :foreign_key => :from_id
end
