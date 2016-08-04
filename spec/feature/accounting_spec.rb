require 'rails_helper'

feature 'Accounting' do
  background do
    @alice = create(:user)
    @bob = create(:user)
  end

  scenario 'user must have a default account' do
    expect(@alice.account).not_to be_nil
  end
end
