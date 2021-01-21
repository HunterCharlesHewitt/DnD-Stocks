# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_21_173358) do

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.text "minute_stocks_robot", default: "--- []\n"
    t.text "day_stocks_robot", default: "--- []\n"
    t.text "minute_stocks_human", default: "--- []\n"
    t.text "day_stocks_human", default: "--- []\n"
    t.text "minute_stocks_elf", default: "--- []\n"
    t.text "day_stocks_elf", default: "--- []\n"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.text "wealth", default: "--- []\n"
    t.text "minute_stocks", default: "--- []\n"
    t.text "day_stocks", default: "--- []\n"
    t.string "company_invested"
    t.string "reh"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
