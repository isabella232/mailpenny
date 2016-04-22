# spec/models/vehicle_spec.rb
require 'rails_helper'

describe PhoneNumber do
  before(:each) do
    @user = build(:user)
  end

  it 'has a valid factory' do
    expect(@user).to be_valid
  end

  it 'sends a verification code when saved' do
    @user.save
    @user.phone_number = build(:phone_number)
    expect(@user.phone_number).to be_valid
  end

  it 'should not be verified by default' do
    @user.save
    @user.phone_number = build(:phone_number)
    expect(@user.phone_number.verified?).to_not be true
  end

  ## disabled because I'm currently not faking web requests
  # it 'should not verify without a code' do
  #   @user.save
  #   @user.phone_number = build(:phone_number)
  #   @user.phone_number.verify_token(nil)
  #   expect(@user.phone_number.verified?).to_not be true
  # end
  #
  # it 'should verify the correct code' do
  #   @user.save
  #   @user.phone_number = build(:phone_number)
  #   @user.phone_number.verify_token('1234')
  #   expect(@user.phone_number.verified?).to be true
  # end
end
