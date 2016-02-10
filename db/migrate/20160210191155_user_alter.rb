class UserAlter < ActiveRecord::Migration
  def change
    add_column :users, "reward" ,:float
    add_column :users , "name" , :string
    add_column :users , "picture" ,:string
  end
end
