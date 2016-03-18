class LinkUserAndHuman < ActiveRecord::Migration
  def change
    remove_column :profiles, :user_id
    add_column :humen, :profile_id, :integer
    add_column :profiles, :user_id, :integer
  end
end
