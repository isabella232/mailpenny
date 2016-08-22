class CreatePhoneNumbers < ActiveRecord::Migration[5.0]
  def change
    create_table :phone_numbers do |t|
      t.references :user, foreign_key: true, null: false
      t.string :country_code, null: false
      t.string :phone_number, null: false
      t.string :authy_id, null: false
      t.boolean :confirmed, default: false, null: false

      t.timestamps
    end
  end
end
