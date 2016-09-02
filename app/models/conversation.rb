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
# **`closed`**        | `boolean`          |
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

class Conversation < ApplicationRecord
  belongs_to :user, foreign_key: :initiator_id
  belongs_to :user, foreign_key: :recipient_id
  has_one :escrow_transaction
  has_many :messages

  before_create :set_defaults
  before_create :create_escrow_transaction

  validates :subject,
            presence: true

  validates :initiator,
            presence: true

  validates :recipient,
            presence: true

  enum status: {
    pending: 1, # the initiator has sent the message
    completed: 2, # the recipient has replied and escrow is closed
    expired: 3, # the recipient did not reply in time and escrow was reversed
    closed: 4 # the conversation is closed and new messages cannot be added
  }

  # mark the conversation as expired and reverse the escrow
  def expire
    self.status = 'expire'
    escrow_transaction.reverse
    save
  end

  # mark the conversation as completed and transfer the escrow
  def complete
    self.status = 'complete'
    escrow_transaction.complete
    save
  end

  # mark the conversation as closed and create no more new messages
  def close
    self.closed = true
    save
  end

  private

  # set the defaults for the migration
  def set_defaults
    self.status = 'pending'
    self.closed = false
    save
  end

  # Initiate the escrow transaction by transfering money into the escrow account
  def create_escrow_transaction
    fee = recipient.rate_email
    self.escrow_transaction = EscrowTransaction.new(
      from: initiator,
      to: recipient,
      amount: fee
    )
  end
end
