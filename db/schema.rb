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

ActiveRecord::Schema.define(version: 20170714210641) do

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
    t.integer "zip_code"
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
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
