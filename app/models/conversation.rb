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

  before_create :determine_fee_amount
  before_create :create_escrow_transaction

  validates :subject,
            presence: true

  validates :initiator,
            presence: true

  validates :recipient,
            presence: true

  validates :fee_amount,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  enum status: {
    open: 1, # the initiator has sent the message
    completed: 2, # the recipient has replied and escrow is closed
    closed: 3 # the conversation is closed and new messages cannot be added
  }

  enum medium: {
    email: 1, # the messages are delivered via email
    sms: 2 # the messages are delivered via sms
  }

  private

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
