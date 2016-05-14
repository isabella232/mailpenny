# spec/models/user_spec.rb
require 'rails_helper'

describe User do
  before(:each) do
    @user = build(:user)
    @charitable_user = build(:user, :charitable)
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

  context 'Stripe ID' do
    it 'should not be writable' do
      expect { @user.stripe_customer_id = 'random_id_123123' }
        .to raise_error(NoMethodError)
    end

    it 'should be generated if it does not exist' do
      @user.save
      expect(@user.stripe_customer_id).to include('cus')
    end

    it 'should not be regenerated upon every call' do
      @user.save
      id = @user.stripe_customer_id
      expect(@user.stripe_customer_id).to eq(id)
    end
  end

  context 'fees' do
    it 'should be fifty percent for regular users' do
      @user.save
      expect(@user.fee).to eq(BigDecimal('0.5'))
    end
    it 'should be twenty percent for charitable users' do
      @charitable_user.save
      expect(@charitable_user.fee).to eq(BigDecimal('0.2'))
    end
    it 'should not be negative for sms' do
      @user.fee_sms = -1
      expect { @user.validate! }.to raise_error 'Validation failed: ' \
      'Fee sms must be greater than or equal to 0'
    end
    it 'should not be negative for email' do
      @user.fee_email = -1
      expect { @user.validate! }.to raise_error 'Validation failed: ' \
      'Fee email must be greater than or equal to 0'
    end
    it 'can be zero for sms' do
      @user.fee_sms = 0
      expect { @user.validate! }.to_not raise_error
    end
    it 'can be zero for email' do
      @user.fee_email = 0
      expect { @user.validate! }.to_not raise_error
    end
    it 'can be greater than zero for sms' do
      @user.fee_sms = 9
      expect { @user.validate! }.to_not raise_error
    end
    it 'can be greater than zero for email' do
      @user.fee_email = 9
      expect { @user.validate! }.to_not raise_error
    end
  end
end
