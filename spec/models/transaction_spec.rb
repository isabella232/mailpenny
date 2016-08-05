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

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'when validating' do
    it 'should be invalid without a transaction_type' do
      tx = Transaction.new
      tx.valid?
      expect(tx.invalid?).to be true
    end
    it 'should be invalid without from_id and to_id accounts' do
      tx = Transaction.new
      tx.valid?
      expect(
        tx.errors.keys.include?(:account) &&
        tx.errors.keys.include?(:from_id) &&
        tx.errors.keys.include?(:to_id) &&
        tx.errors.messages[:account].count == 2
      ).to be true
    end
  end
end
