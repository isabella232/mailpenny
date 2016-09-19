class CreateTransfers < ActiveRecord::Migration[5.0]
  def change
    create_table :transfers do |t|
      t.integer  "from_id"
      t.integer  "to_id"
      t.decimal  "amount",                default: "0.0"
      t.integer  "transaction_type",                      null: false
      t.integer  "escrow_transaction_id"
      t.index ["escrow_transaction_id"], name: "index_transfers_on_escrow_transaction_id", using: :btree
      t.index ["from_id"], name: "index_transfers_on_from_id", using: :btree
      t.index ["to_id"], name: "index_transfers_on_to_id", using: :btree

      t.timestamps
    end
  end
end
