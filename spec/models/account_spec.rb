# <!-- BEGIN GENERATED ANNOTATION -->
# ## Schema Information
#
# Table name: `accounts`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `integer`          | `not null, primary key`
# **`balance`**       | `decimal(, )`      | `default(0.0)`
# **`account_type`**  | `integer`          | `not null`
# **`user_id`**       | `integer`          |
# **`created_at`**    | `datetime`         | `not null`
# **`updated_at`**    | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_accounts_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_b1e30bebc8`:
#     * **`user_id => users.id`**
#
# <!-- END GENERATED ANNOTATION -->

require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'User accounts' do
    before do
      @alice = create(:user)
      @bob = create(:user)
    end

    it 'must exist for new users' do
      expect(@alice.account).not_to be_nil
    end

    it 'balance must not be nil' do
      expect(@alice.account.balance).not_to be_nil
    end

    it 'must not be valid without an account_type' do
      account = Account.new
      account.valid?
      expect(account.errors.keys.include?(:account_type)).to be true
    end

    it 'user accounts must not be valid without a user' do
      account = Account.new
      account.account_type = 'user'
      account.valid?
      expect(account.errors.keys.include?(:user)).to be true
    end

    it 'escrow accounts must not be valid without a conversation' do
      account = Account.new
      account.account_type = 'escrow'
      account.valid?
      expect(account.errors.keys.include?(:conversation)).to be true
    end
  end

  context 'Escrow accounts' do
    context 'when a conversation will be completed it', order: :defined do
      before do
        @alice = create :user
        @alice.account.deposit(500)
        @alice_opening_balance = @alice.account.balance
        @bob = create :user
        @bob.profile = build :profile
        @bob_opening_balance = @alice.account.balance
        @conversation = @alice.send_message(@bob, 'subject', 'message body')
        @escrow_account = @conversation.account
        @rate = @conversation.recipient.profile.rate
      end

      it 'should exist for a new conversation' do
        expect(@escrow_account).to_not be nil
      end

      it 'should have an opening transfer from the get go' do
        expect(@escrow_account.transfers.count).to eq 1
      end

      it 'should have a balance equal to the rate of the recipient' do
        expect(@escrow_account.balance).to eq @rate
      end

      it 'should have decreased the balance of the sender account by the rate' do
        expect(@alice_opening_balance - @alice.account.balance).to eq @rate
      end

      it 'should have a balance of zero when the conversation is completed' do
        @conversation.complete
        expect(@escrow_account.balance).to eq 0
      end

      it 'should have increased the balance of the recipient account' do
        @conversation.complete
        expect(@bob_opening_balance - @bob.account.balance).to be > 0
      end
    end

    context 'when a conversation will expire it', order: :defined do
      before do
        @alice = create :user
        @alice_opening_balance = @alice.account.balance
        @bob = create :user
        @bob_opening_balance = @alice.account.balance
        @conversation = @alice.send_message(@bob, 'subject', 'message body')
        @escrow_account = @conversation.account
        @rate = @conversation.recipient.profile.rate
      end

      it 'should have a balance of zero when the conversation is expired' do
        @conversation.expire
        expect(@conversation.account.balance).to eq 0
      end

      it 'should have refunded the balance of the sender account' do
        @conversation.complete
        expect(@bob_opening_balance - @bob.account.balance).to eq 0
      end
    end
  end
  context 'Meta accounts' do
    it 'only one withdrawal account must exist' do
      withdrawal_accounts = Account.where(account_type: 'withdrawal')
      expect(withdrawal_accounts.count).to eq(1)
    end

    it 'only one deposit account must exist' do
      deposit_accounts = Account.where(account_type: 'deposit')
      expect(deposit_accounts.count).to eq(1)
    end

    it 'only one fee account must exist' do
      fee_accounts = Account.where(account_type: 'fee')
      expect(fee_accounts.count).to eq(1)
    end

    it 'must not be able to create another withdrawal account' do
      new_withdrawal_account = Account.new(account_type: 'withdrawal')
      expect(
        new_withdrawal_account.invalid? &&
        new_withdrawal_account.errors.messages[:account_type] ==
        ['has already been taken']
      ).to be true
    end

    it 'must not be able to create another deposit account' do
      new_deposit_account = Account.new(account_type: 'deposit')
      expect(
        new_deposit_account.invalid? &&
        new_deposit_account.errors.messages[:account_type] ==
        ['has already been taken']
      ).to be true
    end

    it 'must not be able to create another fee account' do
      new_fee_account = Account.new(account_type: 'fee')
      expect(
        new_fee_account.invalid? &&
        new_fee_account.errors.messages[:account_type] ==
        ['has already been taken']
      ).to be true
    end
  end

  # TODO: fix these tests with the new escrow pattern. These tests were written
  #   when users could do direct transfers, but with escrows, users send money
  #   to the escrow account first.
  #
  context 'deposits and withdrawals', order: :defined do
    before :context do
      @alice = create :user
      @deposit_amount = rand(25_000) # random num upto 25000
      @withdraw_amount = rand(@deposit_amount) # random num upto the deposit
    end
    it 'no deposits must exist beforehand' do
      expect(@alice.account.deposits.count).to eq(0)
    end

    it 'deposits must increase balance' do
      @alice.account.deposit @deposit_amount
      expect(@alice.account.balance).to eq(@deposit_amount)
    end

    it 'one depsits must exist afterwards' do
      expect(@alice.account.deposits.count).to eq(1)
    end

    it 'no withdrawals from alice must exist beforehand' do
      expect(@alice.account.withdrawals.count).to eq(0)
    end

    it 'withdrawals must decrease balance' do
      @alice.account.withdraw @withdraw_amount
      expect(@alice.account.balance).to eq(@deposit_amount - @withdraw_amount)
    end

    it 'one withdrawal from alice must now exist' do
      expect(@alice.account.withdrawals.count).to eq(1)
    end
  end
end
