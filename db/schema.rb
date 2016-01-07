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

ActiveRecord::Schema.define(version: 20160107215133) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "documents", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "file"
  end

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

  add_index "events", ["mine_id"], name: "index_events_on_mine_id"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

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

  create_table "order_details", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "mine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "first_approval"
    t.integer  "second_approval"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "state"
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
    t.integer  "photo_type"
  end

  add_index "photos", ["id"], name: "index_photos_on_id"
  add_index "photos", ["mine_id"], name: "index_photos_on_mine_id"
  add_index "photos", ["user_id"], name: "index_photos_on_user_id"

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
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "user_group_id"
    t.string   "work_items"
    t.datetime "last_seen_at"
    t.string   "current_ids"
    t.string   "page_ids"
    t.string   "unique_session_id",      limit: 20
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["id"], name: "index_users_on_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
