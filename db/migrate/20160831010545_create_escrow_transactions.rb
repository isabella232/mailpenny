class CreateEscrowTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :escrow_transactions do |t|
      t.references :from, foreign_key: true
      t.references :to, foreign_key: true
      t.boolean :is_open
      t.integer :state
      t.references :conversation, foreign_key: true
      t.references :opening_transaction, foreign_key: true
      t.references :closing_transaction, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
