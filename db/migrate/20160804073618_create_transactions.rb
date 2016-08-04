class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.references :from, foreign_key: true
      t.references :to, foreign_key: true
      t.decimal :amount, default: 0
      t.integer :type, null: false

      t.timestamps
    end
  end
end
