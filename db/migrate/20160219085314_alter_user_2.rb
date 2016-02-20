class AlterUser2 < ActiveRecord::Migration
  def change
    add_column :users, "BTC_address" ,:string
  end
end
