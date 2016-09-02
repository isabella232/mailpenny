class AddClosedToConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :closed, :boolean
  end
end
