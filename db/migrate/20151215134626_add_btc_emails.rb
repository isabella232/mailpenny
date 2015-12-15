class AddBtcEmails < ActiveRecord::Migration
  def change

    add_column :emails,"btc_address",:string

  end
end
