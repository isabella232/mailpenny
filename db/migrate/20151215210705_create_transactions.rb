class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.float 'amount'
      t.string 'to'
      t.string 'btc_address'
      t.integer 'email_id'
      t.integer 'user_id'
      t.timestamps
    end
  end
end
