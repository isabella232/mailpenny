class CreateWhitelists < ActiveRecord::Migration
  def change
    create_table :whitelists do |t|
      t.string 'email'
      t.integer 'user_id'
      t.timestamps
    end
  end
end
