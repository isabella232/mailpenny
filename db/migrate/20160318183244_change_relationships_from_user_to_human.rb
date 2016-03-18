class ChangeRelationshipsFromUserToHuman < ActiveRecord::Migration
  def change
    remove_column :emails, :user_id, :integer
    add_column    :emails, :human_id, :integer

    remove_column :phones, :user_id, :integer
    add_column    :phones, :human_id, :integer

    remove_column :rewards, :user_id, :integer
    add_column    :rewards, :human_id, :integer

    remove_column :social_media, :user_id, :integer
    add_column    :social_media, :human_id, :integer

    remove_column :whitelists, :user_id, :integer
    add_column    :whitelists, :human_id, :integer

    remove_column :user_emails, :user_id, :integer
    add_column    :user_emails, :human_id, :integer
  end
end
