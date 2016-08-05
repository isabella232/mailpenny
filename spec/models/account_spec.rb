# == Schema Information
#
# Table name: accounts
#
#  id           :integer          not null, primary key
#  balance      :decimal(, )      default(0.0)
#  account_type :integer          not null
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Account, type: :model do
  before :each do
    @alice = create(:user)
    @bob = create(:user)
  end

  it 'must exist for new users' do
    expect(@alice.account).not_to be_nil
  end

  it 'balance must not be nil' do
    expect(@alice.account.balance).not_to be_nil
  end

  it 'deposits must increase balance' do
    @alice.account.deposit 500
    expect(@alice.account.balance).to eq(500)
  end

  it 'must not be valid without an account_type' do
    account = Account.new
    expect(account.valid?).to be false
  end
end
