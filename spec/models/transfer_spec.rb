# <!-- BEGIN GENERATED ANNOTATION -->
# ## Schema Information
#
# Table name: `transfers`
#
# ### Columns
#
# Name                 | Type               | Attributes
# -------------------- | ------------------ | ---------------------------
# **`id`**             | `integer`          | `not null, primary key`
# **`from_id`**        | `integer`          |
# **`to_id`**          | `integer`          |
# **`amount`**         | `decimal(, )`      | `default(0.0)`
# **`transfer_type`**  | `integer`          | `not null`
# **`created_at`**     | `datetime`         | `not null`
# **`updated_at`**     | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_transfers_on_from_id`:
#     * **`from_id`**
# * `index_transfers_on_to_id`:
#     * **`to_id`**
#
# <!-- END GENERATED ANNOTATION -->

require 'rails_helper'

RSpec.describe Transfer, type: :model do
  context 'when validating' do
    it 'should be invalid without a transfer_type' do
      tx = Transfer.new
      tx.valid?
      expect(tx.invalid?).to be true
    end
    it 'should be invalid without from_id and to_id accounts' do
      tx = Transfer.new
      tx.valid?
      expect(
        tx.errors.keys.include?(:from) &&
        tx.errors.keys.include?(:to)
      ).to be true
    end
  end
  context 'user transfers:', order: :defined do
    before :context do
      @alice = create(:user)
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
        @transfer = @alice.account.deposits.last
      end
      it 'alice must have one deposit' do
        deposit_transfers = @alice.account.deposits
        expect(deposit_transfers.count).to eq(1)
      end

      it "alice's deposit transfer amount must be correct" do
        expect(@transfer.amount).to eq(@deposit_amount)
      end

      it "alice's deposit transfer must be to alice" do
        expect(@transfer.to_id).to eq(@alice.account.id)
      end

      it "alice's deposit transfer must be from the deposit account" do
        deposit_account = Account.find_by(account_type: 'deposit')
        expect(@transfer.from_id).to eq(deposit_account.id)
      end
    end

    # it 'alice must have no transfers form her' do
    #   expect(@alice.account.transfers_from.empty?).to be true
    # end
    #
    # it 'bob must have no transfers to him' do
    #   expect(@bob.account.transfers_to.empty?).to be true
    # end
    #
    # context 'after transfering money from alice to bob' do
    #   before :context do
    #     @alice.account.transfer(@transfer_amount, @bob.account)
    #     @transfer = @alice.account.transfers_from.last
    #   end
    #   it 'a transfer from alice to bob must exist' do
    #     from_transfer = @alice.account.transfers_from.last.id
    #     to_transfer = @bob.account.transfers_to.last.id
    #     expect(from_transfer).to eq(to_transfer)
    #   end
    #
    #   it 'the transfer amount must be correct' do
    #     expect(@transfer.amount).to eq(@transfer_amount)
    #   end
    #
    #   it 'the transfer must be to bob' do
    #     expect(@transfer.to_id).to eq(@bob.account.id)
    #   end
    #
    #   it 'the transfer must be from alice' do
    #     expect(@transfer.from_id).to eq(@alice.account.id)
    #   end
    # end

    it 'bob must have no withdrawals' do
      expect(@bob.account.withdrawals.count).to eq(0)
    end
    context "after withdrawing money from bob's account" do
      before :context do
        @bob.account.withdraw @withdraw_amount
        @transfer = @bob.account.withdrawals.last
      end
      it 'a withdrawal transfer must exist' do
        expect(@bob.account.withdrawals.count).to eq(1)
      end
      it "bob's withdrawal transfer amount must be correct" do
        expect(@transfer.amount).to eq(@withdraw_amount)
      end

      it "bob's withdrawal transfer must be from bob" do
        expect(@transfer.from_id).to eq(@bob.account.id)
      end

      it "bob's withdrawal transfer must be to the withdrawal account" do
        deposit_account = Account.find_by(account_type: 'withdrawal')
        expect(@transfer.to_id).to eq(deposit_account.id)
      end
    end
  end
end
