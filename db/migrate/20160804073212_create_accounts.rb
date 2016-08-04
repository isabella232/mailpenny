class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.decimal :balance
      t.integer :type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
