class CreateLedgers < ActiveRecord::Migration
  def change
    create_table :ledgers do |t|
      t.timestamps null: false
      t.integer :from_id
      t.integer :to_id
      t.decimal :amount
      t.string :currency
      t.boolean :payment
      t.boolean :deposit
      t.boolean :withdrawal
      t.string :ref
      t.string :meta
    end
  end
end
