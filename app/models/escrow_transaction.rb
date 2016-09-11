# ## Schema Information
#
# Table name: `escrow_transactions`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `integer`          | `not null, primary key`
# **`from_id`**          | `integer`          |
# **`to_id`**            | `integer`          |
# **`state`**            | `integer`          |
# **`amount`**           | `decimal(, )`      |
# **`created_at`**       | `datetime`         | `not null`
# **`updated_at`**       | `datetime`         | `not null`
# **`conversation_id`**  | `integer`          |
#
# ### Indexes
#
# * `index_escrow_transactions_on_conversation_id`:
#     * **`conversation_id`**
# * `index_escrow_transactions_on_from_id`:
#     * **`from_id`**
# * `index_escrow_transactions_on_to_id`:
#     * **`to_id`**
#
# ### Foreign Keys
#
# * `fk_rails_0c4e4a285d`:
#     * **`to_id => accounts.id`**
# * `fk_rails_abcc2686a1`:
#     * **`from_id => accounts.id`**
#

# A record of funds held, paid or reversed escrow
class EscrowTransaction < ApplicationRecord
  belongs_to :from, foreign_key: :from_id, class_name: 'Account'
  belongs_to :to, foreign_key: :to_id, class_name: 'Account'
  belongs_to :opening_transaction, foreign_key: :opening_transaction_id, class_name: 'Transaction'
  belongs_to :closing_transaction, foreign_key: :closing_transaction_id, class_name: 'Transaction'

  before_validation :determine_amount
  before_create :set_defaults
  before_create :create_escrow_transaction

  validates :amount,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  enum state: {
    pending: 1, # money is in escrow
    completed: 2, # money was delivered to original recepient
    reversed: 3 # money was reversed and delivered to original sender
  }

  # mark the transaction as completed and pay out the rate
  def complete
    EscrowTransaction.transaction do
      self.state = 'completed'
      Account.find_by(account_type: 'escrow').transfer(
        amount,
        to,
        'payment'
      )
    end
  end

  def reverse
    EscrowTransaction.transaction do
      self.state = 'reversed'
      Account.find_by(account_type: 'escrow').transfer(
        amount,
        from,
        'reversal'
      )
    end
  end

  private

  # set default values
  def set_defaults
    self.state = 'pending'
  end

  # determine the recipient's fee and set that as the amount
  def determine_amount
    self.amount = to.user.profile.rate
  end

  # create the escrow transaction
  def create_escrow_transaction
    to.transfer(
      amount,
      to_id,
      'escrow',
      id
    )
  end
end
