# == Schema Information
#
# Table name: accounts
#
#  id           :integer          not null, primary key
#  balance      :decimal(, )      default(0.0)
#  account_type :integer          not null
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

# accounts and their associated balances
class Account < ApplicationRecord
  belongs_to :user, required: false
  has_many :transactions

  enum account_type: {
    user: 1,
    deposit: 2,
    withdrawal: 3,
    fee: 4
  }

  validates :account_type,
            presence: true
  validates :account_type, uniqueness: true, unless: 'account_type == "user"'

  # Transacting money in the system

  # depositing new money into the account, i.e cashing in
  def deposit(amount)
    deposit_account = Account.find_by(account_type: :deposit).id
    raise 'No deposit account, has the db been seeded?' if
    deposit_account.nil?

    create_transaction from_id: deposit_account,
                       to_id: id,
                       amount: amount,
                       transaction_type: 'deposit'
    increase_balance amount
  end

  # withdrawing money out of the account and to user's hands, i.e cashing out
  def withdraw(amount)
    withdrawal_account = Account.find_by(account_type: 'withdrawal').id
    raise 'No withdrawal account, has the db been seeded?' if
    withdrawal_account.nil?

    create_transaction from_id: id,
                       to_id: withdrawal_account,
                       amount: amount,
                       transaction_type: 'withdrawal'
    decrease_balance amount
  end

  # transfering money to another account
  def transfer(amount, to)
    to_id = to.id
    tx = {
      from_id: id,
      to_id: to_id,
      amount: amount,
      transaction_type: 'transfer'
    }
    create_transaction tx
    to.increase_balance amount
    decrease_balance amount
  end

  ## Transactions associated with the Account

  # all the deposits to Account
  def deposits
    Transaction.where(
      to_id: id,
      transaction_type: 'deposit'
    )
  end

  # all the withdrawals from Account
  def withdrawals
    Transaction.where(
      from_id: id,
      transaction_type: 'withdrawal'
    )
  end

  # all the transfers from Account
  def transfers_from
    Transaction.where(
      from_id: id,
      transaction_type: 'transfer'
    )
  end

  # all the transfers from Account
  def transfers_to
    Transaction.where(
      to_id: id,
      transaction_type: 'transfer'
    )
  end

  ## increments and decrements to the balance

  # increase balance by
  def increase_balance(amount)
    self.balance += amount
    save
  end

  # decrease balance by
  def decrease_balance(amount)
    self.balance -= amount
    save
  end

  private

  def create_transaction(tx)
    tx.slice! :transaction_type, :amount, :from_id, :to_id
    _transaction = Transaction.create tx
  end

  # hide the setter for balance from the public
  def balance=(amount)
    self[:balance] = amount
  end
end
