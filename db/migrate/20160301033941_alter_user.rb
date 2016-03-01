class AlterUser < ActiveRecord::Migration
  def change
    add_column :users,"phone",:string
    add_column :users,"verified",:integer
    add_column :users,"verification_code",:integer
  end
end
