class AlterCcard < ActiveRecord::Migration
  def change
    rename_column :ccards,:country ,"address_country"
    rename_column :ccards,:zip ,"address_zip"
    rename_column :ccards,:state ,"address_state"
    rename_column :ccards,:city ,"address_city"
  end
end
