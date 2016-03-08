class CreateCcards < ActiveRecord::Migration
  def change
    create_table :ccards do |t|
      t.integer "zip"
      t.string "address_line1"
      t.string "address_line2"
      t.string "city"
      t.string "state"
      t.string "country"
      t.string "brand"
      t.integer "exp_month"
      t.integer "exp_year"
      t.string "funding"
      t.string "last4"
      t.boolean "primary"
      t.integer "user_id"
      t.timestamps null: false
    end
  end
end
