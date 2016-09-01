class AddFeeAmountToConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :fee_amount, :decimal
  end
end
