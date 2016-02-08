class AddEmailHeaders < ActiveRecord::Migration
  def change
    add_column :emails , "header" ,:string
  end
end
