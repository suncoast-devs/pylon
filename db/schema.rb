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

ActiveRecord::Schema.define(version: 2019_05_05_130543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

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

  create_table "attendance_records", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "cohort_date_id"
    t.string "status", limit: 1
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cohort_date_id"], name: "index_attendance_records_on_cohort_date_id"
    t.index ["person_id"], name: "index_attendance_records_on_person_id"
  end

  create_table "cohort_dates", force: :cascade do |t|
    t.bigint "cohort_id"
    t.date "day"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cohort_id"], name: "index_cohort_dates_on_cohort_id"
  end

  create_table "cohorts", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
    t.bigint "program_id"
    t.index ["program_id"], name: "index_cohorts_on_program_id"
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

  create_table "invitations", force: :cascade do |t|
    t.bigint "cohort_id"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cohort_id"], name: "index_invitations_on_cohort_id"
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
    t.string "given_name", comment: "The person's first/given name"
    t.string "family_name", comment: "The person's last/family name"
    t.string "additional_name", comment: "Any additional name"
    t.string "honorific_prefix", comment: "Name prefix"
    t.string "honorific_suffix", comment: "name suffix"
    t.string "nickname", comment: "Any nickname the person prefers"
    t.string "full_name", comment: "Full name, typically given + family"
    t.string "shirt_size", comment: "Shirt size preference"
    t.text "dietary_note", comment: "Any dietary restrictions or preferences"
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

  create_table "student_enrollments", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "cohort_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "units", default: [], array: true
    t.index ["cohort_id"], name: "index_student_enrollments_on_cohort_id"
    t.index ["person_id"], name: "index_student_enrollments_on_person_id"
  end

  create_table "student_profiles", force: :cascade do |t|
    t.bigint "person_id"
    t.string "status"
    t.boolean "is_looking_for_work"
    t.boolean "is_available_for_freelance"
    t.string "specialty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_student_profiles_on_person_id"
  end

  create_table "units", force: :cascade do |t|
    t.bigint "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["program_id"], name: "index_units_on_program_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "person_id"
    t.boolean "is_admin", default: false
    t.string "auth_sub"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "nickname"
    t.string "access_token"
    t.index ["person_id"], name: "index_users_on_person_id"
  end

  add_foreign_key "attendance_records", "cohort_dates"
  add_foreign_key "attendance_records", "people"
  add_foreign_key "cohort_dates", "cohorts"
  add_foreign_key "cohorts", "programs"
  add_foreign_key "emails", "people"
  add_foreign_key "invitations", "cohorts"
  add_foreign_key "notes", "users"
  add_foreign_key "phone_numbers", "people"
  add_foreign_key "student_enrollments", "cohorts"
  add_foreign_key "student_enrollments", "people"
  add_foreign_key "student_profiles", "people"
  add_foreign_key "units", "programs"
  add_foreign_key "users", "people"
end
