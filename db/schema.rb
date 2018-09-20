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

ActiveRecord::Schema.define(version: 2018_08_21_173848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.string "label"
    t.string "street_address"
    t.string "extended_address"
    t.string "locality"
    t.string "region"
    t.string "postal_code"
    t.string "country_name"
    t.string "post_office_box"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "cohorts", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emails", force: :cascade do |t|
    t.bigint "person_id"
    t.string "label"
    t.string "address"
    t.boolean "is_primary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_emails_on_person_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "linkable_type"
    t.bigint "linkable_id"
    t.string "label"
    t.string "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["linkable_type", "linkable_id"], name: "index_links_on_linkable_type_and_linkable_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "notable_type"
    t.bigint "notable_id"
    t.bigint "user_id"
    t.string "label"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notable_type", "notable_id"], name: "index_notes_on_notable_type_and_notable_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "given_name"
    t.string "family_name"
    t.string "additional_name"
    t.string "honorific_prefix"
    t.string "honorific_suffix"
    t.string "nickname"
    t.string "full_name"
    t.string "shirt_size"
    t.text "dietary_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.bigint "person_id"
    t.string "label"
    t.string "tel"
    t.boolean "is_sms_capable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_phone_numbers_on_person_id"
  end

  create_table "programs", force: :cascade do |t|
    t.string "title"
    t.string "identifier"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_profiles", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "cohort_id"
    t.bigint "program_id"
    t.string "status"
    t.boolean "is_looking_for_work"
    t.boolean "is_available_for_freelance"
    t.string "specialty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cohort_id"], name: "index_student_profiles_on_cohort_id"
    t.index ["person_id"], name: "index_student_profiles_on_person_id"
    t.index ["program_id"], name: "index_student_profiles_on_program_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "person_id"
    t.boolean "is_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_users_on_person_id"
  end

  add_foreign_key "emails", "people"
  add_foreign_key "notes", "users"
  add_foreign_key "phone_numbers", "people"
  add_foreign_key "student_profiles", "cohorts"
  add_foreign_key "student_profiles", "people"
  add_foreign_key "student_profiles", "programs"
  add_foreign_key "users", "people"
end
