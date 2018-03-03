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

ActiveRecord::Schema.define(version: 20180303161006) do

  create_table "admin_session_tokens", force: :cascade do |t|
    t.string "session_token"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_admin_session_tokens_on_admin_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.string "email"
    t.string "phone_number"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_admins_on_admin_id"
  end

  create_table "dams", force: :cascade do |t|
    t.string "project_identification_code"
    t.string "name_of_dam"
    t.string "operated_and_maintained_by"
    t.string "longitude_of_dam"
    t.string "latitude_of_dam"
    t.string "year_of_completion"
    t.string "river_basin"
    t.string "river"
    t.string "nearest_city"
    t.string "seismic_zone"
    t.string "type_of_dam"
    t.string "height_above_lowest_foundation"
    t.string "length_of_dam"
    t.string "volume_content_of_dam"
    t.string "gross_storage_capacity"
    t.string "reservoir_area"
    t.string "effective_storage_capacity"
    t.string "purpose"
    t.string "designed_spillway_capacity"
    t.string "state"
    t.string "present_water_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "directories", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "dam_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_session_tokens", force: :cascade do |t|
    t.string "session_token"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_session_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
