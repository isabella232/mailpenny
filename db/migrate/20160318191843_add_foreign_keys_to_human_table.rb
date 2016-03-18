class AddForeignKeysToHumanTable < ActiveRecord::Migration
  def change
    add_column :humen, :reward_id, :integer
    add_column :humen, :social_medium_id, :integer
  end
end
