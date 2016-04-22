# spec/models/vehicle_spec.rb
require 'rails_helper'

describe PhoneNumber do
  before(:each) do
    @user = build(:user)
  end
  it 'has a valid factory' do
    expect(build(:phone_number)).to be_valid
  end
  it 'sends a verification code when saved' do
    @user.save
    @user.phone_number = create(:phone_number)
    expect(@user.phone_number).to be_nil
  end
end
