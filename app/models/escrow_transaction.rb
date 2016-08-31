# == Schema Information
#
# Table name: escrow_transactions
#
#  id                     :integer          not null, primary key
#  from_id                :integer
#  to_id                  :integer
#  is_open                :boolean
#  state                  :integer
#  opening_transaction_id :integer
#  closing_transaction_id :integer
#  amount                 :decimal(, )
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class EscrowTransaction < ApplicationRecord
  belongs_to :from
  belongs_to :to
  belongs_to :conversation
  belongs_to :opening_transaction
  belongs_to :closing_transaction
end
