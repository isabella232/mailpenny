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

ActiveRecord::Schema.define(version: 20160308100311) do

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
    t.string   "username",   limit: 255
    t.string   "password",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activated"
  end

  create_table "emails", force: :cascade do |t|
    t.string   "to",         limit: 255
    t.string   "from",       limit: 255
    t.string   "subject",    limit: 255
    t.string   "body",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id",    limit: 255
    t.string   "header",     limit: 255
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
    t.string   "to",          limit: 255
    t.string   "btc_address", limit: 255
    t.integer  "email_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",      limit: 255
    t.string   "from",        limit: 255
  end

  create_table "user_emails", force: :cascade do |t|
    t.string   "address"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",             limit: 255
    t.string   "coinbase_id",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "BTC_address",       limit: 255
    t.float    "wallet_amount"
    t.string   "phone"
    t.integer  "verified"
    t.integer  "verification_code"
  end

  create_table "whitelists", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
