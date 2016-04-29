# spec/models/user_spec.rb
require 'rails_helper'

describe User do
  before(:each) do
    @user = build(:user)
  end

  it 'should have an account associated' do
    @user.save
    expect(@user.account).to_not be_nil
  end

  it 'has a valid factory' do
    @user.save
    expect(@user).to be_valid
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
    it 'should not be empty' do
      @user.password = ''
      expect(@user).to_not be_valid
    end

    it 'should not be less than 8 characters' do
      @user.password = @user.password_confirmation = 'a' * 7
      expect(@user).to_not be_valid
    end

    it 'can be upto atleast 500 characters' do
      @user.password = @user.password_confirmation = 'a' * 500
      expect(@user).to be_valid
    end
  end

  context 'Stripe IDs' do
    it 'should not be writable' do
      expect { @user.stripe_customer_id << 'random_id_123123' }
        .to raise_error(NoMethodError)
    end

    it 'should be generated if it does not exist' do
      @user.save
      @user.generate_stripe_id
      expect(@user.stripe_customer_id).to include('cus')
    end
    it 'should not be generated if it exists' do
      @user.save
      @user.generate_stripe_id
      expect { @user.generate_stripe_id }
        .to raise_error 'This user already has a Stripe ID'
    end
  end
end
