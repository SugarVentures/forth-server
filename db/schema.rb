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

ActiveRecord::Schema.define(version: 20151006092116) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "ancestry"
    t.string   "names_depth_cache"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "channels", force: :cascade do |t|
    t.string   "title",       default: "", null: false
    t.text     "description"
    t.string   "icon"
    t.string   "banner"
    t.integer  "components"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "deleted_at"
    t.integer  "view_count",  default: 0
  end

  add_index "channels", ["deleted_at"], name: "index_channels_on_deleted_at", using: :btree

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "streams", force: :cascade do |t|
    t.string   "title",           default: "", null: false
    t.datetime "start"
    t.datetime "end"
    t.string   "stream_key",      default: "", null: false
    t.integer  "view_mode"
    t.integer  "age_restriction", default: 0,  null: false
    t.boolean  "group"
    t.boolean  "discussion"
    t.text     "description"
    t.integer  "channel_id"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "deleted_at"
    t.string   "image"
    t.boolean  "temp"
    t.integer  "view_count",      default: 0
    t.string   "game"
    t.integer  "category_id"
  end

  add_index "streams", ["category_id"], name: "index_streams_on_category_id", using: :btree
  add_index "streams", ["deleted_at"], name: "index_streams_on_deleted_at", using: :btree
  add_index "streams", ["stream_key"], name: "index_streams_on_stream_key", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                    default: "",    null: false
    t.string   "encrypted_password",       default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "name",                     default: "",    null: false
    t.datetime "birthday"
    t.string   "fb_id"
    t.string   "fabric_id"
    t.string   "fabric_auth_token"
    t.string   "fabric_auth_token_secret"
    t.string   "about"
    t.datetime "deleted_at"
    t.string   "auth_token"
    t.boolean  "admin",                    default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "title"
    t.string   "file"
    t.integer  "stream_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "thumb"
  end

end
