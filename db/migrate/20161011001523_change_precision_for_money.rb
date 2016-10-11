class ChangePrecisionForMoney < ActiveRecord::Migration[5.0]
  def change
    change_column :accounts, :balance, :decimal, default: 0, null: false, precision: 15, scale: 2
    change_column :transfers, :amount, :decimal, default: 0, null: false, precision: 15, scale: 2
  end
end
