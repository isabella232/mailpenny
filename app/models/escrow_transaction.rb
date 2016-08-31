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

# A record of funds help and/or paid in escrow
class EscrowTransaction < ApplicationRecord
  belongs_to :account, foreign_key: :from_id
  belongs_to :account, foreign_key: :to_id
  belongs_to :transactions, foreign_key: :opening_transaction_id
  belongs_to :transactions, foreign_key: :closing_transaction_id

  enum state: {
    pending: 1,
    completed: 2,
    reversed: 3
  }
end
