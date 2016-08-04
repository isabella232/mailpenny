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
  belongs_to :user, foreign_key: :from_id
  belongs_to :user, foreign_key: :to_id
end
