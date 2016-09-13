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

require 'restricted_usernames'

# People using the app
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable, :lockable,
         :timeoutable

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[a-zA-Z0-9_.-]+\Z/ },
            exclusion: {
              in: RestricedUsernamesIdentifier.new.initial_path_segments,
              message: 'Username unavailable'
            }

  has_one :account
  has_one :profile
  has_one :phone_number
  has_many :social_media_accounts
  has_many :conversations

  before_create :build_default_account

  # Send a new message to a person
  # @param to [User] Person to send the message to.
  # @param subject [String] Subject line limited to 250 characters
  # @param body [Text]
  #
  # @return conversation [Conversation]
  def send_message(to, subject, body)
    conversation = Conversation.create(
      initiator: self,
      recipient: to,
      subject: subject
    )
    conversation.add_message(self, body)
    conversation
  end

  # Conversations initiated by this user
  # @return Array<Conversation>
  def conversations_from
    Conversation.where(initiator: self)
  end

  # Conversations recieved by this user
  # @return Array<Conversation>
  def conversations_to
    Conversation.where(recipient: self)
  end

  # Conversations involving this user
  # @return Array<Conversation>
  def conversations
    [conversations_from, conversations_to].flatten
  end

  private

  def build_default_account
    build_account account_type: 'user'
    true
  end
end
