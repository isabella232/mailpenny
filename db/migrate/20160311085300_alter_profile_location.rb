class AlterProfileLocation < ActiveRecord::Migration
  def change
    add_column :profiles , "location" , :string
  end
end
