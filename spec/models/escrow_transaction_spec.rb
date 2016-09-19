# # <!-- BEGIN GENERATED ANNOTATION -->
# # ## Schema Information
# #
# # Table name: `escrow_transactions`
# #
# # ### Columns
# #
# # Name                          | Type               | Attributes
# # ----------------------------- | ------------------ | ---------------------------
# # **`id`**                      | `integer`          | `not null, primary key`
# # **`from_id`**                 | `integer`          |
# # **`to_id`**                   | `integer`          |
# # **`state`**                   | `integer`          |
# # **`opening_transaction_id`**  | `integer`          |
# # **`closing_transaction_id`**  | `integer`          |
# # **`amount`**                  | `decimal(, )`      |
# # **`created_at`**              | `datetime`         | `not null`
# # **`updated_at`**              | `datetime`         | `not null`
# # **`conversation_id`**         | `integer`          |
# #
# # ### Indexes
# #
# # * `index_escrow_transactions_on_closing_transaction_id`:
# #     * **`closing_transaction_id`**
# # * `index_escrow_transactions_on_conversation_id`:
# #     * **`conversation_id`**
# # * `index_escrow_transactions_on_from_id`:
# #     * **`from_id`**
# # * `index_escrow_transactions_on_opening_transaction_id`:
# #     * **`opening_transaction_id`**
# # * `index_escrow_transactions_on_to_id`:
# #     * **`to_id`**
# #
# # ### Foreign Keys
# #
# # * `fk_rails_0c4e4a285d`:
# #     * **`to_id => accounts.id`**
# # * `fk_rails_0f05cdcec9`:
# #     * **`opening_transaction_id => transactions.id`**
# # * `fk_rails_26cf516315`:
# #     * **`closing_transaction_id => transactions.id`**
# # * `fk_rails_abcc2686a1`:
# #     * **`from_id => accounts.id`**
# #
# # <!-- END GENERATED ANNOTATION -->
#
# require 'rails_helper'
#
# RSpec.describe EscrowTransaction, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
