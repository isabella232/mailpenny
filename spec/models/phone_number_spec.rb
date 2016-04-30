# spec/models/vehicle_spec.rb
require 'rails_helper'

describe PhoneNumber do
  before(:each) do
    @user = build(:user)
  end

  it 'can be created for a user' do
    @user.save
    @user.phone_number = build(:phone_number)
    expect(PhoneNumber.exists? @user.phone_number.id).to be true
  end

  it 'should send verification code on save' do
    @user.phone_number = build(:phone_number)
    @user.save
    expect(@user.phone_number).to receive(:send_verification_code).with(true)
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
