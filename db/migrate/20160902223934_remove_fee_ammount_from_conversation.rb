class RemoveFeeAmmountFromConversation < ActiveRecord::Migration[5.0]
  def change
    remove_column :conversations, :fee_amount, :decimal
  end
end
