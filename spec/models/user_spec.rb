# <!-- BEGIN GENERATED ANNOTATION -->
# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `integer`          | `not null, primary key`
# **`username`**                | `string`           |
# **`email`**                   | `string`           | `default(""), not null`
# **`encrypted_password`**      | `string`           | `default(""), not null`
# **`reset_password_token`**    | `string`           |
# **`reset_password_sent_at`**  | `datetime`         |
# **`remember_created_at`**     | `datetime`         |
# **`sign_in_count`**           | `integer`          | `default(0), not null`
# **`current_sign_in_at`**      | `datetime`         |
# **`last_sign_in_at`**         | `datetime`         |
# **`current_sign_in_ip`**      | `inet`             |
# **`last_sign_in_ip`**         | `inet`             |
# **`confirmation_token`**      | `string`           |
# **`confirmed_at`**            | `datetime`         |
# **`confirmation_sent_at`**    | `datetime`         |
# **`unconfirmed_email`**       | `string`           |
# **`failed_attempts`**         | `integer`          | `default(0), not null`
# **`unlock_token`**            | `string`           |
# **`locked_at`**               | `datetime`         |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_users_on_confirmation_token` (_unique_):
#     * **`confirmation_token`**
# * `index_users_on_email` (_unique_):
#     * **`email`**
# * `index_users_on_reset_password_token` (_unique_):
#     * **`reset_password_token`**
# * `index_users_on_unlock_token` (_unique_):
#     * **`unlock_token`**
# * `index_users_on_username` (_unique_):
#     * **`username`**
#
# <!-- END GENERATED ANNOTATION -->

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation' do
    before do
      @user = build(:user)
    end

    it 'has a valid factory' do
      expect(@user).to be_valid
    end

    it 'should have an account associated' do
      @user.save
      expect(@user.account).to_not be_nil
    end

    context 'usernames' do
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

      it 'can be upto atleast 128 characters' do
        @user.password = @user.password_confirmation = 'a' * 128
        expect(@user).to be_valid
      end
    end
  end

  context 'messaging' do
    before do
      # meet alice
      @alice = create :user
      @alice.profile = build :profile

      # meet bob
      @bob = create :user
      @bob.profile = build :profile
    end

    it 'can send a message to another user' do
      expect { @alice.send_message(@bob, 'subject', 'body ' * 30) }.to_not raise_error
    end
  end

  context 'conversations', order: :defined do
    self.use_transactional_tests = false

    before :context do
      @alice = create :user
      @bob = create :user
    end

    it 'alice has no conversations associated with her' do
      expect(@alice.conversations.count).to eq 0
    end

    it 'bob has no conversations associated with him' do
      expect(@bob.conversations.count).to eq 0
    end

    it 'starts a new conversation' do
      conversation = @alice.send_message(@bob, 'Very Important Subject', 'Hello Bob ' * 30)
      expect(conversation).to_not be_nil
    end

    it 'alice should have one conversation sent from her' do
      expect(@alice.conversations_from.count).to eq 1
    end

    it 'bob should have one conversation sent to him' do
      expect(@bob.conversations_to.count).to eq 1
    end

    it 'the conversation from alice to be the one sent to bob' do
      expect(@alice.conversations.first.id).to eq @bob.conversations.first.id
    end
  end

  # context 'Stripe ID' do
  #   it 'should not be writable' do
  #     expect { @user.stripe_customer_id = 'random_id_123123' }
  #       .to raise_error(NoMethodError)
  #   end
  #
  #   it 'should be generated if it does not exist' do
  #     @user.save
  #     expect(@user.stripe_customer_id).to include('cus')
  #   end
  #
  #   it 'should not be regenerated upon every call' do
  #     @user.save
  #     id = @user.stripe_customer_id
  #     expect(@user.stripe_customer_id).to eq(id)
  #   end
  # end
  #
  # context 'fees' do
  #   it 'should be fifty percent for regular users' do
  #     @user.save
  #     expect(@user.fee).to eq(BigDecimal('0.5'))
  #   end
  #   it 'should be twenty percent for charitable users' do
  #     @charitable_user.save
  #     expect(@charitable_user.fee).to eq(BigDecimal('0.2'))
  #   end
  #   it 'should not be negative for sms' do
  #     @user.fee_sms = -1
  #     expect { @user.validate! }.to raise_error 'Validation failed: ' \
  #     'Fee sms must be greater than or equal to 0'
  #   end
  #   it 'should not be negative for email' do
  #     @user.fee_email = -1
  #     expect { @user.validate! }.to raise_error 'Validation failed: ' \
  #     'Fee email must be greater than or equal to 0'
  #   end
  #   it 'can be zero for sms' do
  #     @user.fee_sms = 0
  #     expect { @user.validate! }.to_not raise_error
  #   end
  #   it 'can be zero for email' do
  #     @user.fee_email = 0
  #     expect { @user.validate! }.to_not raise_error
  #   end
  #   it 'can be greater than zero for sms' do
  #     @user.fee_sms = 9
  #     expect { @user.validate! }.to_not raise_error
  #   end
  #   it 'can be greater than zero for email' do
  #     @user.fee_email = 9
  #     expect { @user.validate! }.to_not raise_error
  #   end
  # end
end
