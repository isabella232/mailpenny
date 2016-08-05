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
