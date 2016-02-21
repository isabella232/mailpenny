class AlterUser3 < ActiveRecord::Migration
  def change
    add_column :users,"wallet_amount",:float
  end
end
