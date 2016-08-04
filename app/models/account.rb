# == Schema Information
#
# Table name: accounts
#
#  id           :integer          not null, primary key
#  balance      :decimal(, )      default(0.0)
#  account_type :integer          not null
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

# accounts and their associated balances
class Account < ApplicationRecord
  belongs_to :user, required: false
  has_many :transactions
end
