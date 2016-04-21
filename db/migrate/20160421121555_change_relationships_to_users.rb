class ChangeRelationshipsToUsers < ActiveRecord::Migration
  def change
    rename_column :accounts, :human_id, :user_id
    rename_column :emails,   :human_id, :user_id
    rename_column :phone_numbers, :human_id, :user_id
    rename_column :profiles, :human_id, :user_id
    rename_column :rewards, :human_id, :user_id
    rename_column :social_media, :human_id, :user_id
    rename_column :twitter_accounts, :human_id, :user_id
    rename_column :user_emails, :human_id, :user_id
    rename_column :whitelists, :human_id, :user_id
  end
end
