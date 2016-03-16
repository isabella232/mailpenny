class SetDefaultBalanceToZero < ActiveRecord::Migration
  def change
    change_column :accounts, :balance, :decimal, default: 0
  end
end
