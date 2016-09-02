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
  before :context do
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
    expect(account.valid?).to be false
  end

  context 'when db has been seeded' do
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

  context 'when moving money', order: :defined do
    before(:context) do
      @deposit_amount = rand(25_000) # random num upto 25000
      @transfer_amount = rand(@deposit_amount) # random num upto the deposit
      @withdraw_amount = rand(@transfer_amount) # random num upto the transfer
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

    it 'no transfers_from alice must exist beforehand' do
      expect(@alice.account.transfers_from.count).to eq(0)
    end

    it 'no transfers_to bob must exist beforehand' do
      expect(@bob.account.transfers_to.count).to eq(0)
    end

    it 'transfers must decrease sender balance' do
      @alice.account.transfer @transfer_amount, @bob.account
      expect(@alice.account.balance).to eq(@deposit_amount - @transfer_amount)
    end

    it 'one transfers_from alice must exist beforehand' do
      expect(@alice.account.transfers_from.count).to eq(1)
    end

    it 'one transfers_to bob must exist beforehand' do
      expect(@bob.account.transfers_to.count).to eq(1)
    end

    it 'transfers must increase reciever balance' do
      expect(@bob.account.balance).to eq(@transfer_amount)
    end

    it 'no withdrawals from bob must exist beforehand' do
      expect(@bob.account.withdrawals.count).to eq(0)
    end

    it 'withdrawals must decrease balance' do
      @bob.account.withdraw @withdraw_amount
      expect(@bob.account.balance).to eq(@transfer_amount - @withdraw_amount)
    end

    it 'one withdrawals from bob must exist beforehand' do
      expect(@bob.account.withdrawals.count).to eq(1)
    end
  end
end
