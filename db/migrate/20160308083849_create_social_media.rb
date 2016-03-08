class CreateSocialMedia < ActiveRecord::Migration
  def change
    create_table :social_media do |t|
      t.string "facebook"
      t.string "twitter"
      t.string "linkedin"
      t.integer "user_id"
      t.timestamps null: false
    end
  end
end
