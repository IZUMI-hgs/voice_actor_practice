# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_24_054826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "quotes", force: :cascade do |t|
    t.string "title", null: false
    t.string "quote_image"
    t.string "opposite_voice"
    t.integer "emotion", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_quotes_on_title", unique: true
  end

  create_table "results", force: :cascade do |t|
    t.string "uuid", null: false
    t.bigint "quote_id", null: false
    t.string "result_message"
    t.string "voice_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quote_id"], name: "index_results_on_quote_id"
    t.index ["uuid"], name: "index_results_on_uuid", unique: true
  end

  add_foreign_key "results", "quotes"
end
