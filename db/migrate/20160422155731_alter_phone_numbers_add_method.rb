class AlterPhoneNumbersAddMethod < ActiveRecord::Migration
  def change
    add_column :phone_numbers, :verification_method, :string
  end
end
