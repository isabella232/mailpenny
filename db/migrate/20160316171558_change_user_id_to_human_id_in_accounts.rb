class ChangeUserIdToHumanIdInAccounts < ActiveRecord::Migration
  def change
    rename_column :accounts, :user_id, :human_id
  end
end
