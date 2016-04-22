class AlterPhoneNumbersAddAuthyId < ActiveRecord::Migration
  def change
    add_column :phone_numbers, :authy_id, :integer
  end
end
