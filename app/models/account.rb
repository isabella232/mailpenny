# ## Schema Information
#
# Table name: `accounts`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `integer`          | `not null, primary key`
# **`balance`**          | `decimal(, )`      | `default(0.0)`
# **`account_type`**     | `integer`          | `not null`
# **`user_id`**          | `integer`          |
# **`created_at`**       | `datetime`         | `not null`
# **`updated_at`**       | `datetime`         | `not null`
# **`conversation_id`**  | `integer`          |
#
# ### Indexes
#
# * `index_accounts_on_conversation_id`:
#     * **`conversation_id`**
# * `index_accounts_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_b1e30bebc8`:
#     * **`user_id => users.id`**
# * `fk_rails_de2588dd91`:
#     * **`conversation_id => conversations.id`**
#

# Accounting entities that can make transfers and hold balances
class Account < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :conversation, required: false
  has_many :transfers
  after_create :check_if_escrow_and_set_defaults

  enum account_type: {
    user: 1,
    deposit: 2,
    withdrawal: 3,
    fee: 4,
    escrow: 5
  }

  # the account_type attribute must exist
  validates :account_type,
            presence: true

  # account_type must be unique unless this one of many user or escrow accounts
  validates :account_type,
            uniqueness: true,
            unless: 'account_type == "user" || account_type == "escrow"'

  # a unique user must exist if this is a user account
  validates :user,
            presence: true,
            uniqueness: true,
            if: 'account_type == "user"'

  # a unique conversation must exist if this is an escrow account
  validates :conversation,
            presence: true,
            uniqueness: true,
            if: 'account_type == "escrow"'

  # only the deposit account has a normal balance of negative
  validates :balance,
            numericality: { greater_than_or_equal_to: 0 },
            unless: 'account_type == "deposit"'

  ## Transacting money in the system

  # Depositing new money into the account, i.e cashing in
  # @param amount [Decimal]
  def deposit(amount)
    deposit_account = Account.find_by(account_type: :deposit)
    raise 'No deposit account, has the db been seeded?' if
    deposit_account.nil?

    create_transfer('deposit', amount, deposit_account, self)
  end

  # Withdrawing money out of the account and to user's hands, i.e cashing out
  # @param amount [Decimal]
  def withdraw(amount)
    withdrawal_account = Account.find_by(account_type: 'withdrawal')
    raise 'No withdrawal account, has the db been seeded?' if
    withdrawal_account.nil?

    create_transfer('withdrawal', amount, self, withdrawal_account)
  end

  ## Transfers associated with the Account

  # All the deposits to Account
  # @return [Array<Transfer>] a list of transfers
  def deposits
    Transfer.where(
      to: id,
      transfer_type: 'deposit'
    )
  end

  # All the withdrawals from Account
  # @return [Array<Transfer>] a list of transfers
  def withdrawals
    Transfer.where(
      from: id,
      transfer_type: 'withdrawal'
    )
  end

  # All the transfers related to this Account
  # @return [Array<Transfer>] a list of transfers
  def transfers
    t = Transfer.arel_table
    Transfer.where(t[:from_id].eq(id).or(t[:to_id].eq(id)))
  end

  def escrow_complete
    if account_type == 'escrow'
      recipient_account = conversation.recipient.account
      create_transfer 'escrow', balance, self, recipient_account
    end
  end

  def escrow_reverse
    if account_type == 'escrow'
      initiator_account = conversation.initiator.account
      create_transfer 'escrow', balance, self, initiator_account
    end
  end

  ## increments and decrements to the balance

  # Increase balance by
  # @param amount [Decimal] amount to increase balance by
  def increase_balance(amount)
    self.balance += amount
    save
  end

  # Decrease balance by
  # @param amount [Decimal] amount to decrease balance by
  def decrease_balance(amount)
    self.balance -= amount
    save
  end

  private

    # Create a transfer with the following arguments
    # @param transfer_type [String] 'escrow', 'payment', 'reversal',
    #   'deposit', 'withdrawal', 'fees', 'coupon', 'referal'
    # @param amount [Integer]
    # @param from [Account]
    # @param to [Account]
    def create_transfer(transfer_type, amount, from, to)
      Account.transaction do
        Transfer.transaction do
          Transfer.create(
            transfer_type: transfer_type,
            amount: amount,
            from: from,
            to: to
          )
          from.decrease_balance(amount)
          to.increase_balance(amount)
        end
      end
    end

    # Checks if this is an escrow account and sets up the escrow
    def check_if_escrow_and_set_defaults
      # just return true if it isn't an escrow
      if account_type == 'escrow'
        rate = conversation.recipient.profile.rate
        initiator_account = conversation.initiator.account
        create_transfer 'escrow', rate, initiator_account, self
      end
    end

    # The setter for balance, moved to private because it should never be directly
    #   set.
    # @param amount [Decimal]
    def balance=(amount)
      self[:balance] = amount
    end
end
