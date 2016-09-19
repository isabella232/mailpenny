class ChangeColumnTransactionTypeToTransferTypeInTransfers < ActiveRecord::Migration[5.0]
  def change
    rename_column :transfers, :transaction_type, :transfer_type
    remove_column :transfers, :escrow_transaction_id
  end
end
