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

ActiveRecord::Schema.define(version: 20160831022434) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.decimal  "balance",      default: "0.0"
    t.integer  "account_type",                 null: false
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["user_id"], name: "index_accounts_on_user_id", using: :btree
  end

  create_table "conversations", force: :cascade do |t|
    t.string   "subject"
    t.integer  "initiator_id"
    t.integer  "recipient_id"
    t.integer  "status"
    t.integer  "escrow_transaction_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["escrow_transaction_id"], name: "index_conversations_on_escrow_transaction_id", using: :btree
    t.index ["initiator_id"], name: "index_conversations_on_initiator_id", using: :btree
    t.index ["recipient_id"], name: "index_conversations_on_recipient_id", using: :btree
  end

  create_table "escrow_transactions", force: :cascade do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.integer  "state"
    t.integer  "opening_transaction_id"
    t.integer  "closing_transaction_id"
    t.decimal  "amount"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["closing_transaction_id"], name: "index_escrow_transactions_on_closing_transaction_id", using: :btree
    t.index ["from_id"], name: "index_escrow_transactions_on_from_id", using: :btree
    t.index ["opening_transaction_id"], name: "index_escrow_transactions_on_opening_transaction_id", using: :btree
    t.index ["to_id"], name: "index_escrow_transactions_on_to_id", using: :btree
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.string  "unsubscriber_type"
    t.integer "unsubscriber_id"
    t.integer "conversation_id"
    t.index ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
    t.index ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree
  end

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.string   "sender_type"
    t.integer  "sender_id"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.string   "notified_object_type"
    t.integer  "notified_object_id"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
    t.index ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
    t.index ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
    t.index ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
    t.index ["type"], name: "index_mailboxer_notifications_on_type", using: :btree
  end

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.string   "receiver_type"
    t.integer  "receiver_id"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "is_delivered",               default: false
    t.string   "delivery_method"
    t.string   "message_id"
    t.index ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
    t.index ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.integer  "user_id",                      null: false
    t.string   "country_code",                 null: false
    t.string   "phone_number",                 null: false
    t.string   "authy_id",                     null: false
    t.boolean  "confirmed",    default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["user_id"], name: "index_phone_numbers_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name"
    t.text     "bio"
    t.string   "work_company"
    t.string   "work_title"
    t.string   "location"
    t.string   "twitter_username"
    t.decimal  "rate_email",       default: "0.0", null: false
    t.decimal  "rate_sms",         default: "0.0", null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "user_id"
    t.index ["twitter_username"], name: "index_profiles_on_twitter_username", using: :btree
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "social_media_accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "platform",                   null: false
    t.string   "username",                   null: false
    t.string   "url",                        null: false
    t.string   "proof"
    t.boolean  "confirmed",  default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["user_id"], name: "index_social_media_accounts_on_user_id", using: :btree
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.decimal  "amount",           default: "0.0"
    t.integer  "transaction_type",                 null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["from_id"], name: "index_transactions_on_from_id", using: :btree
    t.index ["to_id"], name: "index_transactions_on_to_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "conversations", "escrow_transactions"
  add_foreign_key "conversations", "users", column: "initiator_id"
  add_foreign_key "conversations", "users", column: "recipient_id"
  add_foreign_key "escrow_transactions", "accounts", column: "from_id"
  add_foreign_key "escrow_transactions", "accounts", column: "to_id"
  add_foreign_key "escrow_transactions", "transactions", column: "closing_transaction_id"
  add_foreign_key "escrow_transactions", "transactions", column: "opening_transaction_id"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "phone_numbers", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "social_media_accounts", "users"
  add_foreign_key "transactions", "accounts", column: "from_id"
  add_foreign_key "transactions", "accounts", column: "to_id"
end
