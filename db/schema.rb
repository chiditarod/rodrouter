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

ActiveRecord::Schema.define(version: 2018_12_02_025653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "legs", force: :cascade do |t|
    t.integer "start_id", null: false
    t.integer "end_id", null: false
    t.float "distance", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.integer "max_capacity", null: false
    t.integer "ideal_capacity", null: false
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.float "lat"
    t.float "lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_locations_on_name", unique: true
  end

  create_table "races", force: :cascade do |t|
    t.string "name", null: false
    t.integer "num_checkpoints", null: false
    t.integer "max_teams", null: false
    t.integer "people_per_team", null: false
    t.float "min_total_distance", null: false
    t.float "max_total_distance", null: false
    t.float "min_leg_distance", null: false
    t.float "max_leg_distance", null: false
    t.integer "start_id"
    t.integer "end_id"
    t.integer "distance_unit", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_races_on_name", unique: true
  end

  create_table "routes", force: :cascade do |t|
    t.integer "race_id", null: false
    t.integer "legs", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["legs"], name: "index_routes_on_legs", using: :gin
    t.index ["race_id", "legs"], name: "index_routes_on_race_id_and_legs", unique: true
  end

end
