class AddFeesToLedger < ActiveRecord::Migration
  def change
    rename_column :ledgers, :payment, :type_transfer
    rename_column :ledgers, :deposit, :type_deposit
    rename_column :ledgers, :withdrawal, :type_withdrawal

    change_column :ledgers, :type_transfer, :boolean, default: false
    change_column :ledgers, :type_deposit, :boolean, default: false
    change_column :ledgers, :type_withdrawal, :boolean, default: false
    # specify is the transaction is a fee
    add_column :ledgers, :type_fee, :boolean, default: false

  end
end
