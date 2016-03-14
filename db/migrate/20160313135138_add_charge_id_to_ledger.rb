class AddChargeIdToLedger < ActiveRecord::Migration
  def change
    add_column :ledgers, :stripe_charge_id, :string
  end
end
