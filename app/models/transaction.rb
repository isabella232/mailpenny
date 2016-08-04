# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  from_id          :integer
#  to_id            :integer
#  amount           :decimal(, )      default(0.0)
#  transaction_type :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

# A record of the transactions our users do
class Transaction < ApplicationRecord
  belongs_to :account, foreign_key: :from_id
  belongs_to :account, foreign_key: :to_id

  enum tranasaction_type: {
    transfer: 1,
    deposit: 2,
    withdrawal: 3,
    fees: 4
  }
end
