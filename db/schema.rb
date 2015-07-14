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

ActiveRecord::Schema.define(version: 20150629101611) do

  create_table "activities", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "location"
    t.datetime "time"
    t.integer  "nrofpeopleinvited"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "api_keys", force: true do |t|
    t.string   "access_token"
    t.integer  "user_id"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "api_keys", ["user_id"], name: "index_api_keys_on_user_id"

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["activity_id"], name: "index_comments_on_activity_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "goingtoactivities", force: true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "goingtoactivities", ["activity_id"], name: "index_goingtoactivities_on_activity_id"
  add_index "goingtoactivities", ["user_id"], name: "index_goingtoactivities_on_user_id"

  create_table "interests", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interests", ["category_id"], name: "index_interests_on_category_id"

  create_table "pending_interests", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "pending_interests", ["user_id"], name: "index_pending_interests_on_user_id"

  create_table "user_interests", force: true do |t|
    t.integer  "user_id"
    t.integer  "interest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_interests", ["interest_id"], name: "index_user_interests_on_interest_id"
  add_index "user_interests", ["user_id"], name: "index_user_interests_on_user_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.text     "description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "authy_id"
    t.boolean  "verified"
    t.string   "country_code"
    t.string   "password_digest"
  end

end
