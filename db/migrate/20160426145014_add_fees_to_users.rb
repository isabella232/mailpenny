class AddFeesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fee_email, :decimal, default: 0
    add_column :users, :fee_sms, :decimal, default: 0
  end
end
