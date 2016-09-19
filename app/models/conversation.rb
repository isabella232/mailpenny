# ## Schema Information
#
# Table name: `conversations`
#
# ### Columns
#
# Name                               | Type               | Attributes
# ---------------------------------- | ------------------ | ---------------------------
# **`id`**                           | `integer`          | `not null, primary key`
# **`subject`**                      | `string`           |
# **`initiator_id`**                 | `integer`          |
# **`recipient_id`**                 | `integer`          |
# **`status`**                       | `integer`          |
# **`created_at`**                   | `datetime`         | `not null`
# **`updated_at`**                   | `datetime`         | `not null`
# **`open`**                         | `boolean`          |
# **`last_opened_by_initiator_at`**  | `datetime`         |
# **`last_opened_by_recipient_at`**  | `datetime`         |
#
# ### Indexes
#
# * `index_conversations_on_initiator_id`:
#     * **`initiator_id`**
# * `index_conversations_on_recipient_id`:
#     * **`recipient_id`**
#
# ### Foreign Keys
#
# * `fk_rails_bd11b77488`:
#     * **`initiator_id => users.id`**
# * `fk_rails_f0edaae389`:
#     * **`recipient_id => users.id`**
#

# A conversation groups several messages together
class Conversation < ApplicationRecord
  belongs_to :initiator, foreign_key: :initiator_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
  has_one :escrow_transaction
  has_many :messages

  before_create :set_defaults
  before_create :create_escrow_transaction

  validates :subject,
            presence: true

  validates :initiator_id,
            presence: true

  validates :recipient_id,
            presence: true

  enum status: {
    pending: 1, # the initiator has sent the message
    completed: 2, # the recipient has replied and escrow is closed
    expired: 3 # the recipient did not reply in time and escrow was reversed
  }

  # Mark the conversation as expired and reverse the escrow
  def expire
    self.status = 'expired'
    escrow_transaction.reverse
    save
  end

  # Mark the conversation as completed and transfer the escrow
  def complete
    self.status = 'completed'
    # escrow_transaction.complete
    save
  end

  # Mark the conversation as closed and create no more new messages
  def close
    self.open = false
    save
  end

  # Messages send by the initiator in this conversation
  def messages_by_initiator
    messages.where(sender_id: initiator_id)
  end

  # Messages send by the initiator in this conversation
  def messages_by_recipient
    messages.where(sender_id: recipient_id)
  end

  # Who's participating in this conversation
  # @return [Array(User, User)] The Initiator and Recipient in array form
  def users
    [initiator, recipient]
  end

  # Returns the other user in this conversations
  # @param this_one [User] the user you don't want to see
  # @return [User] the other user
  def users_except(this_one)
    that_one = users
    that_one.delete(this_one)
    that_one.first
  end

  # Has this conversation been read by this user?
  # @param user [User] the user you want to check for
  # @return [Boolean] yes, or no
  def read_by?(user)
    return true if messages.last.sender == user
    return false if initiator == user &&
                    initiator_opened_conversation_since_last_message_was_sent? ||
                    recipient == user &&
                    recipient_opened_conversation_since_last_message_was_sent?
    true
  end

  # this conversation has been opened by the intiator
  def opened_by_initiator
    self.last_opened_by_initiator_at = Time.zone.now
    save
  end

  # this conversation has been opened by the recipient
  def opened_by_recipient
    self.last_opened_by_recipient_at = Time.zone.now
    save
  end

  # Add a new message to the conversation
  # @param from [User] person sending the message
  # @param body [Text] message text being sent
  def add_message(from, body)
    message = Message.new(
      sender: from,
      recipient: users_except(from),
      body: body
    )
    messages << message
    save
  end

  private

    # set the defaults for the conversation
    def set_defaults
      self.status = 'pending'
      self.open = true
    end

    # The method name is descriptive enough
    # @return [Boolean]
    def initiator_opened_conversation_since_last_message_was_sent?
      last_opened_by_initiator_at.nil? ||
        last_opened_by_initiator_at < messages.last.created_at
    end

    # The method name is descriptive enough
    # @return [Boolean]
    def recipient_opened_conversation_since_last_message_was_sent?
      last_opened_by_recipient_at.nil? ||
        last_opened_by_recipient_at < messages.last.created_at
    end

    # Initiate the escrow transaction by transfering money into the escrow account
    def create_escrow_transaction
      # TODO: uncomment this after conversations work
      # fee = User.find(recipient_id).profile.rate
      # self.escrow_transaction = EscrowTransaction.new(
      #   from_id: initiator,
      #   to_id: recipient,
      #   amount: fee
      # )
      Rails.logger.debug { 'created escrow tranasction' }
      true
    end
end
