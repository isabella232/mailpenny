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
  context 'user transactions:', order: :defined do
    before do
      @alice = create(:user)
      @bob = create(:user)
    end

    it 'alice must have no deposits' do
      expect(@alice.account.deposits.empty?).to be true
    end

    it 'after depositing alice must have one deposit transaction' do
      amount = 3000
      @alice.account.deposit(amount)
      expect(@alice.account.deposits.last.amount).to eq(amount)
    end

    it 'alice must have no transfers form her' do
      expect(@alice.account.transfers_from.empty?).to be true
    end

    it 'bob must have no transfers to him' do
      expect(@bob.account.transfers_to.empty?).to be true
    end

    it 'a transaction from alice to bob must exist when transfer is made' do
      @alice.account.transfer(2000, @bob.account)
      from_transaction = @alice.account.transfers_from.last.id
      to_transaction = @bob.account.transfers_to.last.id
      expect(from_transaction).to eq(to_transaction)
    end
  end
end
