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

ActiveRecord::Schema.define(version: 20130818041403) do

  create_table "cars", force: true do |t|
    t.text     "description"
    t.string   "make"
    t.string   "color"
    t.string   "license_plate"
    t.string   "damage"
    t.integer  "incident_id"
    t.string   "driver_name"
    t.text     "driver_contact"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cars", ["incident_id"], name: "index_cars_on_incident_id"

  create_table "incidents", force: true do |t|
    t.text     "description"
    t.datetime "datetime_of_incident"
    t.string   "location"
    t.string   "police_report_number"
    t.string   "video"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "severity"
    t.integer  "user_id"
    t.integer  "score_override"
    t.integer  "score"
  end

  add_index "incidents", ["user_id"], name: "index_incidents_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

  create_table "witnesses", force: true do |t|
    t.string   "name"
    t.text     "contact"
    t.integer  "privacy_level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "incident_id"
  end

  add_index "witnesses", ["incident_id"], name: "index_witnesses_on_incident_id"

end
