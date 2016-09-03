class RemoveOpeningAndClosingTransactionFromEscrowTransactions < ActiveRecord::Migration[5.0]
  def change
    remove_column :escrow_transactions, :opening_transaction_id, :integer
    remove_column :escrow_transactions, :closing_transaction_id, :integer
  end
end
