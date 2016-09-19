class AddConversationRefencesToAccount < ActiveRecord::Migration[5.0]
  def change
    add_reference :accounts, :conversation, foreign_key: true
  end
end
