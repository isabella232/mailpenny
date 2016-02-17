class EditTransactions < ActiveRecord::Migration
  def change
    add_column :transactions,"from" ,:string
  end
end
