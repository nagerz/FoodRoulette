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

ActiveRecord::Schema.define(version: 2019_04_09_015334) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "phone_numbers", force: :cascade do |t|
    t.bigint "survey_id"
    t.string "digits"
    t.bigint "vote_id"
    t.index ["survey_id"], name: "index_phone_numbers_on_survey_id"
    t.index ["vote_id"], name: "index_phone_numbers_on_vote_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "yelp_id"
    t.string "name"
    t.string "address_1"
    t.string "address_2"
    t.string "address_3"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "country"
    t.string "phone"
    t.text "image_url"
    t.float "rating"
    t.string "price"
    t.float "latitude"
    t.float "longitude"
    t.integer "reviews"
    t.string "category_1"
    t.string "category_2"
    t.string "category_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_restaurants", force: :cascade do |t|
    t.bigint "survey_id"
    t.bigint "restaurant_id"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_survey_restaurants_on_restaurant_id"
    t.index ["survey_id"], name: "index_survey_restaurants_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["user_id"], name: "index_surveys_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "google_id"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.text "refresh_token"
    t.text "thumbnail"
  end

  create_table "visits", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "restaurant_id"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_visits_on_restaurant_id"
    t.index ["user_id"], name: "index_visits_on_user_id"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "survey_restaurant_id"
    t.index ["survey_id"], name: "index_votes_on_survey_id"
    t.index ["survey_restaurant_id"], name: "index_votes_on_survey_restaurant_id"
  end

  add_foreign_key "phone_numbers", "surveys"
  add_foreign_key "survey_restaurants", "restaurants"
  add_foreign_key "survey_restaurants", "surveys"
  add_foreign_key "surveys", "users"
  add_foreign_key "visits", "restaurants"
  add_foreign_key "visits", "users"
  add_foreign_key "votes", "surveys"
end
