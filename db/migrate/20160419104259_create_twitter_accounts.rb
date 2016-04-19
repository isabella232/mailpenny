class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    change_table :twitter_accounts do |t|
      t.timestamps
    end

    change_column :twitter_accounts, :created_at, :datetime, null: false
    change_column :twitter_accounts, :updated_at, :datetime, null: false
  end
end
