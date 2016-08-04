class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.references :from, index: true
      t.references :to, index: true
      t.decimal :amount, default: 0
      t.integer :type, null: false

      t.timestamps
    end
    add_foreign_key :transactions, :accounts, column: :from_id
    add_foreign_key :transactions, :accounts, column: :to_id
  end
end
