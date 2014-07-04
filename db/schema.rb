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

ActiveRecord::Schema.define(version: 20140704192154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "api_keys", force: true do |t|
    t.string   "username",                                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "consumer_key"
    t.string   "consumer_secret"
    t.string   "token"
    t.string   "token_secret"
    t.integer  "day_count",        default: 0
    t.integer  "historical_count", default: 0
    t.boolean  "enabled",          default: true
    t.datetime "reset_at",         default: '2014-02-05 01:25:16'
  end

  create_table "content_types", force: true do |t|
    t.string   "name",           null: false
    t.integer  "tumblr_type_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url_match"
  end

  create_table "posts", force: true do |t|
    t.string   "reddit_id",       null: false
    t.string   "title",           null: false
    t.integer  "sub_id",          null: false
    t.string   "tumblr_id"
    t.integer  "content_type_id"
    t.datetime "submitted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "json"
    t.integer  "whitelist_id"
    t.boolean  "garbage"
    t.datetime "processed_at"
    t.hstore   "response"
    t.datetime "removed_at"
  end

  add_index "posts", ["reddit_id"], name: "index_posts_on_reddit_id", unique: true, using: :btree

  create_table "subs", force: true do |t|
    t.string   "name",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "css"
    t.text     "js"
    t.boolean  "enabled",    default: true
    t.boolean  "nsfw",       default: false
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tumblr_types", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "whitelists", force: true do |t|
    t.string   "domain",         null: false
    t.string   "match"
    t.string   "replace"
    t.integer  "tumblr_type_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url_match"
  end

end
