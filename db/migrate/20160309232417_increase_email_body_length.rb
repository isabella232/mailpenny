class IncreaseEmailBodyLength < ActiveRecord::Migration
  def change
    change_column :emails, :body, :text
  end
end
