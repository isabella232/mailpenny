class DropDeprecatedTables < ActiveRecord::Migration
  def change
    drop_table "whitelists", force: :cascade do |t|
      t.string   "email"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "user_id"
    end

    drop_table "views", force: :cascade do |t|
      t.string   "email",                  default: "", null: false
      t.string   "encrypted_password",     default: "", null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          default: 0,  null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.datetime "created_at",                          null: false
      t.datetime "updated_at",                          null: false
    end

    drop_table "user_emails", force: :cascade do |t|
      t.string   "address"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer  "user_id"
    end

    drop_table "social_media", force: :cascade do |t|
      t.string   "facebook"
      t.string   "twitter"
      t.string   "linkedin"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer  "user_id"
    end

    drop_table "emails", force: :cascade do |t|
      t.string   "to"
      t.string   "from"
      t.string   "subject"
      t.text     "body"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "header"
      t.integer  "user_id"
    end

  end
end