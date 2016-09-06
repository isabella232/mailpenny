# <!-- BEGIN GENERATED ANNOTATION -->
# ## Schema Information
#
# Table name: `conversations`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `integer`          | `not null, primary key`
# **`subject`**       | `string`           |
# **`initiator_id`**  | `integer`          |
# **`recipient_id`**  | `integer`          |
# **`status`**        | `integer`          |
# **`created_at`**    | `datetime`         | `not null`
# **`updated_at`**    | `datetime`         | `not null`
# **`open`**          | `boolean`          |
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
# <!-- END GENERATED ANNOTATION -->

# A conversation groups several messages together
class Conversation < ApplicationRecord
  belongs_to :user, foreign_key: :initiator_id
  belongs_to :user, foreign_key: :recipient_id
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
    self.status = 'expire'
    escrow_transaction.reverse
    save
  end

  # Mark the conversation as completed and transfer the escrow
  def complete
    self.status = 'complete'
    escrow_transaction.complete
    save
  end

  # Mark the conversation as closed and create no more new messages
  def close
    self.open = false
    save
  end

  # Messages send by the initiator in this conversation
  def messages_by_initiator
    Message.where(sender_id: initiator_id)
  end

  # Messages send by the initiator in this conversation
  def messages_by_recipient
    Message.where(sender_id: recipient_id)
  end

  # Who's participating in this conversation
  # @return [Array(User, User)] The Initiator and Recipient in array form
  def participants
    [initiator_id, recipient_id]
  end

  # Add a new message to the conversation
  # @param from [User.id] person sending the message
  # @param body [Text] message text being sent
  def add_message(from, body)
    message = Message.new(
      sender_id: from,
      recipient_id: participants.delete(from),
      body: body
    )
    messages << message
  end

  private

  # set the defaults for the migration
  def set_defaults
    self.status = 'pending'
    self.open = true
  end

  # Initiate the escrow transaction by transfering money into the escrow account
  def create_escrow_transaction
    fee = User.find(recipient_id).profile.rate
    self.escrow_transaction = EscrowTransaction.new(
      from_id: initiator_id,
      to_id: recipient_id,
      amount: fee
    )
  end
end
