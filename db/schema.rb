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

ActiveRecord::Schema.define(version: 20151102154133) do

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "user_email"
    t.integer  "category"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "level"
    t.integer  "mine_id"
  end

  create_table "gps_files", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.integer  "user_id"
    t.integer  "count"
    t.boolean  "imported"
    t.datetime "created_at"
  end

# Could not dump table "mines" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "notes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string   "file_id"
    t.integer  "mine_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.string   "file"
    t.string   "description"
  end

  create_table "user_groups", force: :cascade do |t|
    t.text "description"
  end

  create_table "user_notes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.integer  "user_group_id"
    t.string   "work_items"
    t.datetime "last_seen_at"
    t.string   "current_ids"
    t.string   "page_ids"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
