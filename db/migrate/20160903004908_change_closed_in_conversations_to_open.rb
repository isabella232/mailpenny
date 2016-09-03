class ChangeClosedInConversationsToOpen < ActiveRecord::Migration[5.0]
  def change
    remove_column :conversations, :closed, :boolean
    add_column :conversations, :open, :boolean
  end
end
