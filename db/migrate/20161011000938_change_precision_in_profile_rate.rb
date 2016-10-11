class ChangePrecisionInProfileRate < ActiveRecord::Migration[5.0]
  def change
    change_column :profiles, :rate, :decimal, default: 0, null: false, precision: 15, scale: 2
  end
end
