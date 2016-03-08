class AlterUserProfile < ActiveRecord::Migration
  def change
    remove_column :users,:name
    remove_column :users , :picture
    remove_column :users , :reward
    add_column :profiles,"first_name",:string
    add_column :profiles , "last_name",:string
  end
end
