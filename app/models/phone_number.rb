# ## Schema Information
#
# Table name: `phone_numbers`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `integer`          | `not null, primary key`
# **`user_id`**       | `integer`          | `not null`
# **`country_code`**  | `string`           | `not null`
# **`phone_number`**  | `string`           | `not null`
# **`authy_id`**      | `string`           | `not null`
# **`confirmed`**     | `boolean`          | `default(FALSE), not null`
# **`created_at`**    | `datetime`         | `not null`
# **`updated_at`**    | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_phone_numbers_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_af796b956a`:
#     * **`user_id => users.id`**
#

# phone numbers
class PhoneNumber < ApplicationRecord
  belongs_to :user

  before_save :register_authy_user

  # Send the a confirmation token via sms
  def request_verification_sms
    response = Authy::API.request_sms id: authy_id
    if response.ok?
      true
    else
      response.errors
    end
  end

  # Send the a confirmation token via phone call
  def request_verification_call
    response = Authy::API.request_phone_call id: authy_id
    if response.ok?
      true
    else
      response.errors
    end
  end

  # Verify a confirmation token
  # @param token [String] a six digit authy confirmation token
  def verify(token)
    response = Authy::API.verify(id: authy_id, token: token)
    if response.ok?
      self.confirmed = true
      save
    else
      response.errors
    end
  end

  private

  # Register a User on Authy and save the result to the `authy_id` attribute
  # @return [String] A unique Authy id for the phone number
  def register_authy_user
    authy = Authy::API.register_user(
      email: user.email,
      cellphone: phone_number,
      country_code: country_code
    )
    if authy.ok?
      self.authy_id = authy.id
    else
      authy.errors
    end
  end
end
