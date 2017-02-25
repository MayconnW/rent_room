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

ActiveRecord::Schema.define(version: 20170219004113) do

  create_table "apartments", force: :cascade do |t|
    t.string   "description", limit: 255
    t.string   "number",      limit: 255
    t.integer  "hotel_id",    limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "apartments", ["hotel_id"], name: "index_apartments_on_hotel_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.date     "born"
    t.string   "country",    limit: 255
    t.string   "phone",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "hotels", force: :cascade do |t|
    t.string   "description", limit: 255
    t.string   "address",     limit: 255
    t.string   "cep",         limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "payment_rents", force: :cascade do |t|
    t.integer  "rent_id",    limit: 4
    t.integer  "month",      limit: 4
    t.integer  "year",       limit: 4
    t.float    "value",      limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "payment_rents", ["rent_id"], name: "index_payment_rents_on_rent_id", using: :btree

  create_table "payment_secures", force: :cascade do |t|
    t.integer  "rent_id",    limit: 4
    t.float    "value",      limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "payment_secures", ["rent_id"], name: "index_payment_secures_on_rent_id", using: :btree

  create_table "rents", force: :cascade do |t|
    t.integer  "room_id",     limit: 4
    t.integer  "client_id",   limit: 4
    t.integer  "day_payment", limit: 4
    t.integer  "status",      limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "rents", ["client_id"], name: "index_rents_on_client_id", using: :btree
  add_index "rents", ["room_id"], name: "index_rents_on_room_id", using: :btree

  create_table "rich_rich_files", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rich_file_file_name",    limit: 255
    t.string   "rich_file_content_type", limit: 255
    t.integer  "rich_file_file_size",    limit: 4
    t.datetime "rich_file_updated_at"
    t.string   "owner_type",             limit: 255
    t.integer  "owner_id",               limit: 4
    t.text     "uri_cache",              limit: 65535
    t.string   "simplified_type",        limit: 255,   default: "file"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "description",  limit: 255
    t.string   "number",       limit: 255
    t.integer  "apartment_id", limit: 4
    t.float    "price_month",  limit: 24
    t.float    "price_secure", limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "rooms", ["apartment_id"], name: "index_rooms_on_apartment_id", using: :btree

  create_table "user_apis", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "token",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "user_apis", ["user_id"], name: "index_user_apis_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "name",                   limit: 255
    t.string   "url",                    limit: 255
    t.string   "photo_file_name",        limit: 255
    t.string   "photo_content_type",     limit: 255
    t.integer  "photo_file_size",        limit: 4
    t.datetime "photo_updated_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "role_id",                limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "apartments", "hotels"
  add_foreign_key "payment_rents", "rents"
  add_foreign_key "payment_secures", "rents"
  add_foreign_key "rents", "clients"
  add_foreign_key "rents", "rooms"
  add_foreign_key "rooms", "apartments"
  add_foreign_key "user_apis", "users"
  add_foreign_key "users", "roles"
end
