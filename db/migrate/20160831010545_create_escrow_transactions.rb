class CreateEscrowTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :escrow_transactions do |t|
      t.references :from, index: true
      t.references :to, index: true
      t.boolean :is_open
      t.integer :state
      t.references :opening_transaction, index: true
      t.references :closing_transaction, index: true
      t.decimal :amount

      t.timestamps
    end
    add_foreign_key :escrow_transactions, :accounts, column: :from_id
    add_foreign_key :escrow_transactions, :accounts, column: :to_id
    add_foreign_key :escrow_transactions, :transactions, column: :opening_transaction_id
    add_foreign_key :escrow_transactions, :transactions, column: :closing_transaction_id
  end
end
