# spec/models/account_spec.rb
require 'rails_helper'

describe Account do
  before(:each) do
    @alice = create(:user)
    @bob = create(:user)
    @eve = create(:user, charitable)
  end

  context 'should be built whenever' do
    it "Alice's user is created" do
      expect(@alice.account).to_not be_nil
    end

    it "Bob's user is created" do
      expect(@bob.account).to_not be_nil
    end

    it "Eve's user is created" do
      expect(@eve.account).to_not be_nil
    end
  end

  it 'balance should increase upon deposit' do
    @alice.account.deposit(amount: 50)
    expect(@alice.account.balance).to eq(50.to_d)
  end

  it 'balance should decrease upon withdrawal' do
    amount = 50.to_d
    @alice.account.deposit(amount: amount)
    fail if @alice.account.balance != amount
    @alice.account.withdraw(amount: amount)
    expect(@alice.account.balance).to eq(0.to_d)
  end

  it 'balance should increase for the recepient \
        by the amount transfered minus fees' do
    amount = 50.to_d
    @alice.account.deposit(amount: amount)
    fail if @alice.account.balance != amount
    fail unless @bob.account.valid?
    @alice.account.transfer(amount: amount, to: @bob.account)
    amount_after_fee = amount - (amount * @bob.fee)
    expect(@bob.account.balance).to eq(amount_after_fee)
  end

  it 'balance should decrease for the sender by the amount transfered' do
    amount = 50.to_d
    @alice.account.deposit(amount: amount)
    fail if @alice.account.balance != amount
    fail unless @bob.account.valid?
    @alice.account.transfer(amount: amount, to: @bob.account)
    expect(@alice.account.balance).to eq(0)
  end

  it 'balance should increase by the fee amount for the meta Revenue account' do
    amount = 50.to_d
    @alice.account.deposit(amount: amount)
    fail if @alice.account.balance != amount
    fail unless @bob.account.valid?
    @alice.account.transfer(amount: amount, to: @bob.account)
    fee_amount = amount * @bob.fee
    fee_account = Account.find_by(meta_name: 'revenue')
    expect(fee_account.balance).to eq(fee_amount)
  end
end
