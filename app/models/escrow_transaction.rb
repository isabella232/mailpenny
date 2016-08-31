# ## Schema Information
#
# Table name: `escrow_transactions`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `integer`          | `not null, primary key`
# **`from_id`**                 | `integer`          |
# **`to_id`**                   | `integer`          |
# **`state`**                   | `integer`          |
# **`opening_transaction_id`**  | `integer`          |
# **`closing_transaction_id`**  | `integer`          |
# **`amount`**                  | `decimal(, )`      |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
# **`conversation_id`**         | `integer`          |
#
# ### Indexes
#
# * `index_escrow_transactions_on_closing_transaction_id`:
#     * **`closing_transaction_id`**
# * `index_escrow_transactions_on_conversation_id`:
#     * **`conversation_id`**
# * `index_escrow_transactions_on_from_id`:
#     * **`from_id`**
# * `index_escrow_transactions_on_opening_transaction_id`:
#     * **`opening_transaction_id`**
# * `index_escrow_transactions_on_to_id`:
#     * **`to_id`**
#
# ### Foreign Keys
#
# * `fk_rails_0c4e4a285d`:
#     * **`to_id => accounts.id`**
# * `fk_rails_0f05cdcec9`:
#     * **`opening_transaction_id => transactions.id`**
# * `fk_rails_26cf516315`:
#     * **`closing_transaction_id => transactions.id`**
# * `fk_rails_abcc2686a1`:
#     * **`from_id => accounts.id`**
#

# A record of funds held, paid or reversed escrow
class EscrowTransaction < ApplicationRecord
  belongs_to :account, foreign_key: :from_id
  belongs_to :account, foreign_key: :to_id
  belongs_to :transactions, foreign_key: :opening_transaction_id
  belongs_to :transactions, foreign_key: :closing_transaction_id

  enum state: {
    pending: 1, # money is in escrow
    completed: 2, # money was delivered to original recepient
    reversed: 3 # money was reversed and delivered to original sender
  }
end
