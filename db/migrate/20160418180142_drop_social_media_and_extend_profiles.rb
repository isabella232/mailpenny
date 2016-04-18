class DropSocialMediaAndExtendProfiles < ActiveRecord::Migration
  def change
    drop_table "social_media", force: :cascade do |t|
      t.string   "facebook"
      t.string   "twitter"
      t.string   "linkedin"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer  "human_id"
    end

    change_table :profiles do |t|
      t.string   "facebook"
      t.string   "twitter"
      t.string   "linkedin"
      t.remove   "city"
      t.remove   "country"
    end
  end
end
