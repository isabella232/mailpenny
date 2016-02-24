class AlterCred < ActiveRecord::Migration
  def change
    add_column :credentials ,"activated" ,:integer
  end
end
