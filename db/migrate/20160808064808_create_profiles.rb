class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.text :bio
      t.string :work_company
      t.string :work_title
      t.string :location
      t.string :twitter_username, index: true
      t.decimal :rate_email, null: false, default: 0
      t.decimal :rate_sms, null: false, default: 0

      t.timestamps
    end

    # remove columns from the users table
    change_table :users do |t|
      t.remove :name
      t.remove :bio
      t.remove :work_company
      t.remove :work_title
      t.remove :location
      t.remove :twitter_username
      t.remove :rate_email
      t.remove :rate_sms
    end
  end
end
