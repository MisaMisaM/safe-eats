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

ActiveRecord::Schema[7.0].define(version: 2023_10_13_014656) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additives", force: :cascade do |t|
    t.string "name"
    t.text "information"
    t.float "danger_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.string "purpose"
    t.string "url"
  end

  create_table "allergens", force: :cascade do |t|
    t.string "name"
    t.text "information"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "additive_id"
    t.string "icon"
  end

  create_table "ingredients", force: :cascade do |t|
    t.bigint "additive_id", null: false
    t.bigint "allergen_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["additive_id"], name: "index_ingredients_on_additive_id"
    t.index ["allergen_id"], name: "index_ingredients_on_allergen_id"
  end

  create_table "scans", force: :cascade do |t|
    t.string "image_url"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "allergens", "additives"
  add_foreign_key "ingredients", "additives"
  add_foreign_key "ingredients", "allergens"
end
