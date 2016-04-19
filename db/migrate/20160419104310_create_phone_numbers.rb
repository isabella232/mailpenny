class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    change_table :phone_numbers do |t|
      t.timestamps
    end

    change_column :phone_numbers, :created_at, :datetime, null: false
    change_column :phone_numbers, :updated_at, :datetime, null: false
  end
end
