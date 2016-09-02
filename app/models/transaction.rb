# <!-- BEGIN GENERATED ANNOTATION -->
# ## Schema Information
#
# Table name: `transactions`
#
# ### Columns
#
# Name                    | Type               | Attributes
# ----------------------- | ------------------ | ---------------------------
# **`id`**                | `integer`          | `not null, primary key`
# **`from_id`**           | `integer`          |
# **`to_id`**             | `integer`          |
# **`amount`**            | `decimal(, )`      | `default(0.0)`
# **`transaction_type`**  | `integer`          | `not null`
# **`created_at`**        | `datetime`         | `not null`
# **`updated_at`**        | `datetime`         | `not null`
#
# ### Indexes
#
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
#
# <!-- END GENERATED ANNOTATION -->

# A record of the transactions our users do
class Transaction < ApplicationRecord
  belongs_to :account, foreign_key: :from_id
  belongs_to :account, foreign_key: :to_id

  validates :from_id,
            presence: true

  validates :to_id,
            presence: true

  validates :transaction_type,
            presence: true

  enum tranasaction_type: {
    transfer: 1,
    deposit: 2,
    withdrawal: 3,
    fees: 4
  }
end
