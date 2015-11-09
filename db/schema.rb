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

ActiveRecord::Schema.define(version: 20150502152359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "moneta", id: false, force: :cascade do |t|
    t.string "k", null: false
    t.binary "v"
  end

  add_index "moneta", ["k"], name: "index_moneta_on_k", unique: true, using: :btree

  create_table "parties", force: :cascade do |t|
    t.string   "name"
    t.string   "ticket_number"
    t.text     "comments"
    t.boolean  "rsvp"
    t.datetime "rsvp_by"
    t.string   "sort_name"
    t.datetime "notified_at"
    t.datetime "viewed_at"
    t.datetime "updated_at"
  end

  create_table "people", force: :cascade do |t|
    t.string  "first_name"
    t.integer "party_id"
    t.boolean "attending"
    t.integer "category_id"
    t.integer "sort_order"
  end

  add_index "people", ["category_id"], name: "index_people_on_category_id", using: :btree
  add_index "people", ["party_id"], name: "index_people_on_party_id", using: :btree

end
