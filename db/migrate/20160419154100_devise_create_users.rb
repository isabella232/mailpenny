class DeviseCreateUsers < ActiveRecord::Migration
  def change
    rename_table :humen, :users
  end
end
