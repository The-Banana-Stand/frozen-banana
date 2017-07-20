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

ActiveRecord::Schema.define(version: 20170720175400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "change_requests", force: :cascade do |t|
    t.text "request", null: false
    t.text "admin_comment"
    t.bigint "user_id"
    t.bigint "meeting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id"], name: "index_change_requests_on_meeting_id"
    t.index ["user_id"], name: "index_change_requests_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text "dm_feedback"
    t.text "sp_feedback"
    t.text "admin_feedback"
    t.integer "dm_id"
    t.integer "sp_id"
    t.bigint "meeting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "admin_comments"
    t.index ["meeting_id"], name: "index_feedbacks_on_meeting_id"
  end

  create_table "general_availabilities", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "block"
    t.integer "day"
    t.time "start_time"
    t.time "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "admin_comments"
    t.index ["user_id"], name: "index_general_availabilities_on_user_id"
  end

  create_table "invites", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "company_name", null: false
    t.string "title"
    t.string "company_address"
    t.string "state"
    t.string "zip_code"
    t.string "phone_number"
    t.string "email"
    t.text "admin_comments"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city"
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.index ["user_id"], name: "index_invites_on_user_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.integer "dm_id"
    t.integer "sp_id"
    t.string "status", default: "requested"
    t.integer "price_cents"
    t.string "payment_status", default: "pending"
    t.string "dm_calendar_status", default: "pending"
    t.string "sp_calendar_status", default: "pending"
    t.date "date"
    t.time "time_start"
    t.time "time_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "price_currency", default: "USD", null: false
    t.string "address"
    t.text "admin_comments"
    t.string "meeting_type", default: "in person"
    t.text "instructions"
    t.bigint "general_availability_id"
    t.integer "sort_priority"
    t.text "sp_requested_comments"
    t.string "confirmation_number"
    t.index ["general_availability_id"], name: "index_meetings_on_general_availability_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "company_name"
    t.string "title"
    t.string "email"
    t.string "company_address"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "username"
    t.string "password_digest"
    t.text "sp_product_service"
    t.string "ar_first_name"
    t.string "ar_last_name"
    t.string "ar_email"
    t.string "ar_phone_number"
    t.string "ar_account_number"
    t.string "phone_number"
    t.boolean "active"
    t.string "role"
    t.text "dm_evaluating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean "wildcard", default: true
    t.integer "price_cents", default: 10426, null: false
    t.string "price_currency", default: "USD", null: false
    t.string "customer_token"
    t.text "admin_comments"
    t.boolean "admin", default: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text "ar_comments"
    t.text "filter_comments"
    t.text "validation_comments"
    t.string "plat_validation_status", default: "new"
    t.integer "dm_min_bottom_line_impact", default: 0, null: false
    t.integer "sp_small_bottom_line_impact", default: 0, null: false
    t.integer "sp_medium_bottom_line_impact", default: 0, null: false
    t.integer "sp_large_bottom_line_impact", default: 0, null: false
    t.text "sp_small_impact_examples"
    t.text "sp_medium_impact_examples"
    t.text "sp_large_impact_examples"
    t.integer "sp_sales_cycle", default: 0, null: false
    t.integer "sp_close_percentage", default: 0, null: false
    t.integer "sp_organization_close_percentage", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id"
    t.string "foreign_key_name", null: false
    t.integer "foreign_key_id"
    t.index ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.integer "transaction_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

end
