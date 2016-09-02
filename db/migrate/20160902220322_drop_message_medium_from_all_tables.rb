class DropMessageMediumFromAllTables < ActiveRecord::Migration[5.0]
  def change
    remove_column :conversations, :medium, :integer
    remove_column :profiles, :rate_sms, :decimal
    rename_column :profiles, :rate_email, :rate
  end
end
