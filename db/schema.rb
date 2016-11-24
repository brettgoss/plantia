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

ActiveRecord::Schema.define(version: 20161123222309) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "plantlogs", force: :cascade do |t|
    t.date     "logtime"
    t.string   "title"
    t.text     "logtext"
    t.integer  "plant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_plantlogs_on_plant_id", using: :btree
  end

  create_table "plants", force: :cascade do |t|
    t.string   "nickname"
    t.string   "common_name"
    t.string   "light"
    t.integer  "water_freq"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_plants_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "water_events", force: :cascade do |t|
    t.datetime "water_date"
    t.integer  "plant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_water_events_on_plant_id", using: :btree
  end

  add_foreign_key "plantlogs", "plants"
  add_foreign_key "plants", "users"
  add_foreign_key "water_events", "plants"
end
