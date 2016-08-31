class RemoveIsOpenFromEscrowTransactions < ActiveRecord::Migration[5.0]
  def change
    remove_column :escrow_transactions, :is_open, :boolean
  end
end
