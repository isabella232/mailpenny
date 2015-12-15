class CreateRecievedAmounts < ActiveRecord::Migration
  def change
    create_table :recieved_amounts do |t|
      t.string 'btc_address'
      t.float 'amount'
      t.timestamps
    end
  end
end
