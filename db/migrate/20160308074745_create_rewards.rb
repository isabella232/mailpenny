class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.float "sms"
      t.float "call"
      t.float "email"
      t.integer "user_id"
      t.timestamps null: false
    end
  end
end
