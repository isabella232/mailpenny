require 'rails_helper'

feature 'Accounting' do
  background do
    @alice = create(:user)
    @bob = create(:user)
  end

  scenario 'user must have a default account' do
    expect(@alice.account).not_to be_nil
  end

  scenario 'user balance must not be nil' do
    expect(@alice.account.balance).not_to be_nil
  end

  scenario 'deposits must increase balance' do
    @alice.account.deposit 500
    expect(@alice.account.balance).to eq(500)
  end
end
