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

require 'rails_helper'

RSpec.describe EscrowTransaction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
