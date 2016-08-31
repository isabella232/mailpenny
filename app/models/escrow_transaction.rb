# == Schema Information
#
# Table name: escrow_transactions
#
#  id                     :integer          not null, primary key
#  from_id                :integer
#  to_id                  :integer
#  state                  :integer
#  opening_transaction_id :integer
#  closing_transaction_id :integer
#  amount                 :decimal(, )
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

# A record of funds held, paid or reversed escrow
class EscrowTransaction < ApplicationRecord
  belongs_to :account, foreign_key: :from_id
  belongs_to :account, foreign_key: :to_id
  belongs_to :transactions, foreign_key: :opening_transaction_id
  belongs_to :transactions, foreign_key: :closing_transaction_id

  enum state: {
    pending: 1, # money is in escrow
    completed: 2, # money was delivered to original recepient
    reversed: 3 # money was reversed and delivered to original sender
  }
end
