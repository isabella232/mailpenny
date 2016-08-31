class AddMediumToConversation < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :medium, :integer, index: true
  end
end
