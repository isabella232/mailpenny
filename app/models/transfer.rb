# <!-- BEGIN GENERATED ANNOTATION -->
# ## Schema Information
#
# Table name: `transfers`
#
# ### Columns
#
# Name                 | Type               | Attributes
# -------------------- | ------------------ | ---------------------------
# **`id`**             | `integer`          | `not null, primary key`
# **`from_id`**        | `integer`          |
# **`to_id`**          | `integer`          |
# **`amount`**         | `decimal(, )`      | `default(0.0)`
# **`transfer_type`**  | `integer`          | `not null`
# **`created_at`**     | `datetime`         | `not null`
# **`updated_at`**     | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_transfers_on_from_id`:
#     * **`from_id`**
# * `index_transfers_on_to_id`:
#     * **`to_id`**
#
# <!-- END GENERATED ANNOTATION -->

# A record of the transfers between accounts
class Transfer < ApplicationRecord
  belongs_to :from, foreign_key: :from_id, class_name: 'Account'
  belongs_to :to, foreign_key: :to_id, class_name: 'Account'
  belongs_to :escrow_transfer, required: false

  validates :from_id,
            presence: true

  validates :to_id,
            presence: true

  validates :transfer_type,
            presence: true

  enum transfer_type: {
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
