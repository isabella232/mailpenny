class MoveForeignKeyFromConversationToEscrowTransaction < ActiveRecord::Migration[5.0]
  def change
    remove_reference :conversations, :escrow_transaction, index: true
    add_reference :escrow_transactions, :conversation, index: true
  end
end
