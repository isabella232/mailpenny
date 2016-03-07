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

ActiveRecord::Schema.define(version: 20160301033941) do

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
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
    t.string   "header"
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

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "coinbase_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "reward"
    t.string   "name"
    t.string   "picture"
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
