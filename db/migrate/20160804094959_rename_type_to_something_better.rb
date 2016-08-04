class RenameTypeToSomethingBetter < ActiveRecord::Migration[5.0]
  def change
    rename_column :accounts,     :type, :account_type
    rename_column :transactions, :type, :transaction_type
  end
end
