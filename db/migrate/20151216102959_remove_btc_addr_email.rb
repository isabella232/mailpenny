class RemoveBtcAddrEmail < ActiveRecord::Migration
  def change
    remove_column :emails ,'btc_address'
    add_column :emails , 'user_id', :string
  end
end
