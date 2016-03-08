class CreateUserEmails < ActiveRecord::Migration
  def change
    create_table :user_emails do |t|
      t.string "address"
      t.integer "user_id"
      t.timestamps null: false
    end
  end
end
