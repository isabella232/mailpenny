class DropRedundantTables < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key "transactions", "escrow_transactions"
    drop_table :escrow_transactions
    drop_table :transactions
  end
end
