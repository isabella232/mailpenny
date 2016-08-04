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
    fees: 4
  }

  def deposit(amount)
    deposit_account = Account.find_by(account_type: :deposit).id
    raise 'No deposit account, has the db been seeded?' if
    deposit_account.nil?

    create_transaction from: deposit_account,
                       to: id,
                       amount: amount,
                       transaction_type: :deposit
  end

  def withdraw
    withdrawal_account = Account.find_by(account_type: :withdrawal).id
    raise 'No withdrawal account, has the db been seeded?' if
    withdrawal_account.nil?

    create_transaction from: id,
                       to: withdrawal_account,
                       amount: amount,
                       transaction_type: :withdrawal
  end

  private

  def create_transaction(tx)
    tx.slice! :transaction_type, :amount, :from, :to
    Transaction.create tx
    self.balance += tx.amount
    save
  end
end
