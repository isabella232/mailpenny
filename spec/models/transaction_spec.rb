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
    before :context do
      @alice = build(:user)
      @alice.save
      @bob = create(:user)
      @deposit_amount = rand(25_000) # random num upto 25000
      @transfer_amount = rand(@deposit_amount) # random num upto the deposit
      @withdraw_amount = rand(@transfer_amount) # random num upto the transfer
    end

    it 'alice must have no deposits' do
      expect(@alice.account.deposits.empty?).to be true
    end

    context "after depositing to alice's account" do
      before :context do
        @alice.account.deposit(@deposit_amount)
        @transaction = @alice.account.deposits.last
      end
      it 'alice must have one deposit' do
        deposit_transactions = @alice.account.deposits
        expect(deposit_transactions.count).to eq(1)
      end

      it "alice's deposit transaction amount must be correct" do
        expect(@transaction.amount).to eq(@deposit_amount)
      end

      it "alice's deposit transaction must be to alice" do
        expect(@transaction.to_id).to eq(@alice.account.id)
      end

      it "alice's deposit transaction must be from the deposit account" do
        deposit_account = Account.find_by(account_type: 'deposit')
        expect(@transaction.from_id).to eq(deposit_account.id)
      end
    end

    it 'alice must have no transfers form her' do
      expect(@alice.account.transfers_from.empty?).to be true
    end

    it 'bob must have no transfers to him' do
      expect(@bob.account.transfers_to.empty?).to be true
    end

    context 'after transfering money from alice to bob' do
      before :context do
        @alice.account.transfer(@transfer_amount, @bob.account)
        @transaction = @alice.account.transfers_from.last
      end
      it 'a transaction from alice to bob must exist' do
        from_transaction = @alice.account.transfers_from.last.id
        to_transaction = @bob.account.transfers_to.last.id
        expect(from_transaction).to eq(to_transaction)
      end

      it 'the transaction amount must be correct' do
        expect(@transaction.amount).to eq(@transfer_amount)
      end

      it 'the transaction must be to bob' do
        expect(@transaction.to_id).to eq(@bob.account.id)
      end

      it 'the transaction must be from alice' do
        expect(@transaction.from_id).to eq(@alice.account.id)
      end
    end

    it 'bob must have no withdrawals' do
      expect(@bob.account.withdrawals.count).to eq(0)
    end
    context "after withdrawing money from bob's account" do
      before :context do
        @bob.account.withdraw @withdraw_amount
        @transaction = @bob.account.withdrawals.last
      end
      it 'a withdrawal transaction must exist' do
        expect(@bob.account.withdrawals.count).to eq(1)
      end
      it "bob's withdrawal transaction amount must be correct" do
        expect(@transaction.amount).to eq(@withdraw_amount)
      end

      it "bob's withdrawal transaction must be from bob" do
        expect(@transaction.from_id).to eq(@bob.account.id)
      end

      it "bob's withdrawal transaction must be to the withdrawal account" do
        deposit_account = Account.find_by(account_type: 'withdrawal')
        expect(@transaction.to_id).to eq(deposit_account.id)
      end
    end
  end
end
