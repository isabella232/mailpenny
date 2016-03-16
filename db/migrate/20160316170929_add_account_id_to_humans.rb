class AddAccountIdToHumans < ActiveRecord::Migration
  def change
    add_column :humen, :account_id, :integer
  end
end
