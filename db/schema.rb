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

ActiveRecord::Schema.define(version: 20151122154213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "good_types", force: :cascade do |t|
    t.string   "title"
    t.decimal  "price"
    t.string   "icon"
    t.integer  "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goods", force: :cascade do |t|
    t.integer  "price"
    t.string   "bonus"
    t.integer  "page"
    t.integer  "count"
    t.integer  "good_type_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "goods", ["good_type_id"], name: "index_goods_on_good_type_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "link"
    t.integer  "good_id"
    t.integer  "user_id"
    t.integer  "external_id"
    t.integer  "external_done"
    t.integer  "external_need"
    t.datetime "date_done"
    t.boolean  "done"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "orders", ["good_id"], name: "index_orders_on_good_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "url"
    t.string   "url_original"
    t.string   "url_short"
    t.integer  "likes",        default: 0
    t.integer  "need"
    t.integer  "priority",     default: 0
    t.integer  "reports",      default: 0
    t.integer  "queue"
    t.string   "ip"
    t.boolean  "active",       default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "last_seen_task", default: 0
    t.string   "ip"
    t.boolean  "vip",            default: false
    t.boolean  "banned",         default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_foreign_key "goods", "good_types"
  add_foreign_key "orders", "goods"
  add_foreign_key "orders", "users"
  add_foreign_key "tasks", "users"
end
