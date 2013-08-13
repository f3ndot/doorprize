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

ActiveRecord::Schema.define(version: 20130813161642) do

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
    t.boolean  "injured"
    t.string   "police_report_number"
    t.string   "video"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "severity"
  end

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
