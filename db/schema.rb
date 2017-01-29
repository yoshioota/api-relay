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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "relay_destinations", force: :cascade do |t|
    t.integer  "relay_id",   null: false
    t.string   "base_url",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["relay_id"], name: "index_relay_destinations_on_relay_id", using: :btree
  end

  create_table "relay_logs", force: :cascade do |t|
    t.integer  "relay_id",           null: false
    t.string   "request_method"
    t.string   "request_url"
    t.text     "request_parameters"
    t.text     "request_headers"
    t.binary   "request_body"
    t.integer  "response_status"
    t.text     "response_headers"
    t.binary   "response_body"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["relay_id"], name: "index_relay_logs_on_relay_id", using: :btree
  end

  create_table "relays", force: :cascade do |t|
    t.string   "title"
    t.integer  "max_logs_size"
    t.integer  "active_relay_destination_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
