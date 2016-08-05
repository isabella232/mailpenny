require 'rails_helper'

feature 'Meta account' do
  scenario 'deposit should exist' do
    deposit_account = Account.find_by(account_type: :deposit)
    expect(deposit_account).not_to be_nil
  end
  scenario 'withdrawal should exist' do
    withdrawal_account = Account.find_by(account_type: :withdrawal)
    expect(withdrawal_account).not_to be_nil
  end
  scenario 'fee should exist' do
    fee_account = Account.find_by(account_type: :fee)
    expect(fee_account).not_to be_nil
  end
end
