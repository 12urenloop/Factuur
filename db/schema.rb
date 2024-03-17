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

ActiveRecord::Schema.define(version: 2020_01_04_144931) do

  create_table "addresses", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "beneficiary"
    t.string "street", null: false
    t.string "zip_code", null: false
    t.string "city", null: false
    t.string "country", null: false
    t.bigint "contact_id", null: false
    t.datetime "deleted_at"
    t.index ["contact_id"], name: "index_addresses_on_contact_id"
    t.index ["deleted_at"], name: "index_addresses_on_deleted_at"
  end

  create_table "contacts", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "vatnumber"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_contacts_on_deleted_at"
  end

  create_table "costs", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "description", null: false
    t.decimal "price", precision: 8, scale: 2, default: "0.0", null: false
    t.integer "amount", default: 1, null: false
    t.integer "vat", default: 21, null: false
    t.bigint "note_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_costs_on_deleted_at"
    t.index ["note_id"], name: "index_costs_on_note_id"
  end

  create_table "notes", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind", default: 0, null: false
    t.string "note_number", null: false
    t.string "title", null: false
    t.binary "generated_pdf", size: :long
    t.bigint "contact_id"
    t.datetime "deleted_at"
    t.index ["contact_id"], name: "index_notes_on_contact_id"
    t.index ["deleted_at"], name: "index_notes_on_deleted_at"
  end

end
