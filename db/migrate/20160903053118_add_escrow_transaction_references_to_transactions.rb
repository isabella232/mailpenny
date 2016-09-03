class AddEscrowTransactionReferencesToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_reference :transactions, :escrow_transaction, foreign_key: true, index: true
  end
end
