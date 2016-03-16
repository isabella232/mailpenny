# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160316151832) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ccards", force: :cascade do |t|
    t.integer  "address_zip"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_country"
    t.string   "brand"
    t.integer  "exp_month"
    t.integer  "exp_year"
    t.string   "funding"
    t.string   "last4"
    t.boolean  "primary"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "credentials", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activated"
  end

  create_table "emails", force: :cascade do |t|
    t.string   "to"
    t.string   "from"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
    t.string   "header"
  end

  create_table "humen", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "humen", ["confirmation_token"], name: "index_humen_on_confirmation_token", unique: true
  add_index "humen", ["email"], name: "index_humen_on_email", unique: true
  add_index "humen", ["reset_password_token"], name: "index_humen_on_reset_password_token", unique: true
  add_index "humen", ["unlock_token"], name: "index_humen_on_unlock_token", unique: true
  add_index "humen", ["username"], name: "index_humen_on_username", unique: true

  create_table "ledgers", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "from_id"
    t.integer  "to_id"
    t.decimal  "amount"
    t.string   "currency"
    t.boolean  "payment"
    t.boolean  "deposit"
    t.boolean  "withdrawal"
    t.string   "ref"
    t.string   "meta"
    t.string   "stripe_charge_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string   "number"
    t.string   "country"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "about"
    t.string   "city"
    t.string   "country"
    t.string   "profile_picture"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "location"
  end

  create_table "rewards", force: :cascade do |t|
    t.float    "sms"
    t.float    "call"
    t.float    "email"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "social_media", force: :cascade do |t|
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.float    "amount"
    t.string   "to"
    t.string   "btc_address"
    t.integer  "email_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "from"
  end

  create_table "user_emails", force: :cascade do |t|
    t.string   "address"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "coinbase_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "BTC_address"
    t.float    "wallet_amount"
    t.string   "phone"
    t.integer  "verified"
    t.integer  "verification_code"
  end

  create_table "whitelists", force: :cascade do |t|
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
