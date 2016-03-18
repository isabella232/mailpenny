class DropObsoleteTables < ActiveRecord::Migration
  def change
    drop_table :users
    drop_table :credentials
    drop_table :transactions
  end
end
