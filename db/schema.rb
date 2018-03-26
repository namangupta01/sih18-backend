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

ActiveRecord::Schema.define(version: 20180326090601) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "dam_admin_forgot_passwords", force: :cascade do |t|
    t.string "forgot_password_token"
    t.integer "dam_admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dam_admin_id"], name: "index_dam_admin_forgot_passwords_on_dam_admin_id"
  end

  create_table "dam_admin_session_tokens", force: :cascade do |t|
    t.string "session_token"
    t.integer "dam_admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dam_admin_id"], name: "index_dam_admin_session_tokens_on_dam_admin_id"
  end

  create_table "dam_admins", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.string "email"
    t.string "phone_number"
    t.integer "dam_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dam_id"], name: "index_dam_admins_on_dam_id"
  end

  create_table "dam_water_releases", force: :cascade do |t|
    t.integer "dam_id"
    t.integer "dam_admin_id"
    t.string "description"
    t.datetime "water_release_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dam_admin_id"], name: "index_dam_water_releases_on_dam_admin_id"
    t.index ["dam_id"], name: "index_dam_water_releases_on_dam_id"
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
    t.integer "dam_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dam_id"], name: "index_directories_on_dam_id"
  end

  create_table "help_mes", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.integer "user_id"
    t.integer "dam_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dam_id"], name: "index_help_mes_on_dam_id"
    t.index ["user_id"], name: "index_help_mes_on_user_id"
  end

  create_table "notification_delivereds", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "date_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notification_delivereds_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "message"
    t.integer "notification_type"
    t.string "author"
    t.integer "dam_id"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dam_id"], name: "index_notifications_on_dam_id"
  end

  create_table "user_alert_mappings", force: :cascade do |t|
    t.integer "help"
    t.integer "helper"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_locations", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_locations_on_user_id"
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
    t.boolean "confirmed", default: false
    t.string "confirmation_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dam_id"
    t.index ["dam_id"], name: "index_users_on_dam_id"
  end

end
