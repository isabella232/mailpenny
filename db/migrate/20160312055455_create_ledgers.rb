class CreateLedgers < ActiveRecord::Migration
  def change
    create_table :ledgers do |t|

      t.timestamps null: false
    end
  end
end
