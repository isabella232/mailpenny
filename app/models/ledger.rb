# The ledger that keeps tracking of internal transactions
class Ledger < ActiveRecord::Base
  belongs_to :from, :class_name => 'Account', :foreign_key => :from_id
  belongs_to :to, :class_name => 'Account', :foreign_key => :to_id
end
