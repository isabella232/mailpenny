class AddEmailIdRecieved < ActiveRecord::Migration
  def change
    add_column :recieved_amounts,"email_id",:integer
  end
end
