class AddAccessTimeStampsToConversation < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :last_opened_by_initiator_at, :datetime
    add_column :conversations, :last_opened_by_recipient_at, :datetime
  end
end
