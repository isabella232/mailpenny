# <!-- BEGIN GENERATED ANNOTATION -->
# ## Schema Information
#
# Table name: `accounts`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `integer`          | `not null, primary key`
# **`balance`**       | `decimal(, )`      | `default(0.0)`
# **`account_type`**  | `integer`          | `not null`
# **`user_id`**       | `integer`          |
# **`created_at`**    | `datetime`         | `not null`
# **`updated_at`**    | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_accounts_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_b1e30bebc8`:
#     * **`user_id => users.id`**
#
# <!-- END GENERATED ANNOTATION -->

# Accounting entities that can make transfers and hold balances
class Account < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :conversation, required: false
  has_many :transfers

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
    deposit_account = Account.find_by(account_type: :deposit).id
    raise 'No deposit account, has the db been seeded?' if
    deposit_account.nil?

    Account.transaction do
      create_transfer from_id: deposit_account,
                      to_id: id,
                      amount: amount,
                      transfer_type: 'deposit'
      increase_balance amount
    end
  end

  # Withdrawing money out of the account and to user's hands, i.e cashing out
  # @param amount [Decimal]
  def withdraw(amount)
    withdrawal_account = Account.find_by(account_type: 'withdrawal').id
    raise 'No withdrawal account, has the db been seeded?' if
    withdrawal_account.nil?

    Account.transaction do
      create_transfer from_id: id,
                      to_id: withdrawal_account,
                      amount: amount,
                      transfer_type: 'withdrawal'
      decrease_balance amount
    end
  end

  # Transfering money to another account
  # @param amount [Decimal] the amount being transfered
  # @param to [Account] the account being transfered to
  # @param type [String] the type of transfer being made, i.e. escrow,
  #   'payment', 'deposit', 'withdrawal', or 'fees'
  def transfer(amount, to, type)
    to_id = to.id
    tx = {
      from_id: id,
      to_id: to_id,
      amount: amount,
      transfer_type: type
    }

    Account.transaction do
      create_transfer tx
      to.increase_balance amount
      decrease_balance amount
    end
  end

  ## Transfers associated with the Account

  # All the deposits to Account
  # @return [Array<Transfer>] a list of transfers
  def deposits
    Transfer.where(
      to_id: id,
      transfer_type: 'deposit'
    )
  end

  # All the withdrawals from Account
  # @return [Array<Transfer>] a list of transfers
  def withdrawals
    Transfer.where(
      from_id: id,
      transfer_type: 'withdrawal'
    )
  end

  # All the transfers from Account
  # @return [Array<Transfer>] a list of transfers
  def transfers_from
    Transfer.where(
      from_id: id,
      transfer_type: 'transfer'
    )
  end

  # All the transfers to Account
  # @return [Array<Transfer>] a list of transfers
  def transfers_to
    Transfer.where(
      to_id: id,
      transfer_type: 'transfer'
    )
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
    # @param tx [Hash] Contains `:transfer_type`, `:amount`, `:from_id`, and `:to_id`
    def create_transfer(tx)
      Transfer.transaction do
        tx.slice! :transfer_type, :amount, :from_id, :to_id
        _transfer = Transfer.create tx
      end
    end

    # The setter for balance, moved to private because it should never be directly
    #   set.
    # @param amount [Decimal]
    def balance=(amount)
      self[:balance] = amount
    end
end
