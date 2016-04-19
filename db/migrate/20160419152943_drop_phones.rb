class DropPhones < ActiveRecord::Migration
  def change
    drop_table :phones
  end
end
