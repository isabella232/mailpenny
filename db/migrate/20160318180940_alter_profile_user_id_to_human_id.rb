class AlterProfileUserIdToHumanId < ActiveRecord::Migration
  def change
    remove_column :profiles, :user_id, :integer
    add_column :profiles, :human_id, :integer
  end
end
