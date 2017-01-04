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

ActiveRecord::Schema.define(version: 20161210161609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "activity_id"
    t.integer  "athlete_id"
    t.string   "name"
    t.float    "distance"
    t.integer  "moving_time"
    t.integer  "elapsed_time"
    t.float    "total_elevation_gain"
    t.float    "elev_high"
    t.float    "elev_low"
    t.string   "activity_type"
    t.datetime "start_date"
    t.datetime "start_date_local"
    t.string   "timezone"
    t.string   "start_latlng"
    t.string   "end_latlng"
    t.integer  "achievement_count"
    t.integer  "kudos_count"
    t.integer  "comment_count"
    t.integer  "athlete_count"
    t.integer  "total_photo_count"
    t.float    "average_speed"
    t.float    "max_speed"
    t.float    "calories"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "athletes", force: :cascade do |t|
    t.string   "name"
    t.integer  "strava_id"
    t.text     "picture"
    t.float    "weekly_mileage"
    t.float    "alltime_mileage"
    t.float    "weekly_elevation"
    t.float    "alltime_elevation"
    t.float    "max_elevation_gain"
    t.float    "max_distance"
    t.float    "max_time"
    t.integer  "weekly_time"
    t.integer  "total_time"
    t.float    "weekly_max_speed"
    t.float    "alltime_max_speed"
    t.integer  "sessions"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
