# ## Schema Information
#
# Table name: `transactions`
#
# ### Columns
#
# Name                         | Type               | Attributes
# ---------------------------- | ------------------ | ---------------------------
# **`id`**                     | `integer`          | `not null, primary key`
# **`from_id`**                | `integer`          |
# **`to_id`**                  | `integer`          |
# **`amount`**                 | `decimal(, )`      | `default(0.0)`
# **`transaction_type`**       | `integer`          | `not null`
# **`created_at`**             | `datetime`         | `not null`
# **`updated_at`**             | `datetime`         | `not null`
# **`escrow_transaction_id`**  | `integer`          |
#
# ### Indexes
#
# * `index_transactions_on_escrow_transaction_id`:
#     * **`escrow_transaction_id`**
# * `index_transactions_on_from_id`:
#     * **`from_id`**
# * `index_transactions_on_to_id`:
#     * **`to_id`**
#
# ### Foreign Keys
#
# * `fk_rails_0d6a51be66`:
#     * **`from_id => accounts.id`**
# * `fk_rails_16a782f6da`:
#     * **`to_id => accounts.id`**
# * `fk_rails_c072c6d4b6`:
#     * **`escrow_transaction_id => escrow_transactions.id`**
#

# A record of the transactions between accounts
class Transaction < ApplicationRecord
  belongs_to :account, foreign_key: :from_id
  belongs_to :account, foreign_key: :to_id
  belongs_to :escrow_transaction, required: false

  validates :from_id,
            presence: true

  validates :to_id,
            presence: true

  validates :transaction_type,
            presence: true

  enum transaction_type: {
    escrow: 1,
    payment: 2,
    reversal: 3,
    deposit: 4,
    withdrawal: 5,
    fees: 6,
    coupon: 7,
    referal: 8
  }
end
