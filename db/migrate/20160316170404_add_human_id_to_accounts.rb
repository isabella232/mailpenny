class AddHumanIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :human_id, :integer
  end
end
