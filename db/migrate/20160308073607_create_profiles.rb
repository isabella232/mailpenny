class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string "about"
      t.string "city"
      t.string "country"
      t.string "profile_picture"
      t.integer "user_id"
      t.timestamps null: false
    end
  end
end
