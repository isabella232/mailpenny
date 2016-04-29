# spec/models/vehicle_spec.rb
require 'rails_helper'

describe User do
  before(:each) do
    @user = build(:user)
  end

  it 'has a valid factory' do
    expect(create(:user)).to be_valid
  end

  context 'usernames' do
    it 'should strip whitespace at the ends' do
      @user.username = ' hello '
      @user.save
      expect(@user.username).to eq('hello')
    end

    describe 'cannot' do
      it 'have whitespace' do
        @user.username = 'hello world'
        expect(@user).to_not be_valid
      end
    end

    describe 'can' do
      it 'can have underscores' do
        @user.username = 'hello_world'
        expect(@user).to be_valid
      end

      it 'can have dots' do
        @user.username = 'hello.world'
        expect(@user).to be_valid
      end

      it 'can have dashes' do
        @user.username = 'hello-world'
        expect(@user).to be_valid
      end
    end
  end

  context 'emails' do
    it 'should not be empty' do
      @user.email = ''
      expect(@user).to_not be_valid
    end

    it 'should not have two @s ' do
      @user.email = 'hello@world@lollolol.com'
      expect(@user).to_not be_valid
    end
  end

  context 'passwords' do
    it 'shuold not be empty' do
      @user.password = ''
      expect(@user).to_not be_valid
    end

    it 'should not be less than 8 characters' do
      @user.password = 'a' * 7
      expect(@user).to_not be_valid
    end
  end
end
