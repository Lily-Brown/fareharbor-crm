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

ActiveRecord::Schema.define(version: 20170314022343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "full_name"
    t.string   "title"
    t.string   "work_phone"
    t.string   "email_address"
    t.integer  "customer_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["customer_id"], name: "index_contacts_on_customer_id", using: :btree
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "work_phone"
    t.date     "last_contact_date"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "feature_requests", force: :cascade do |t|
    t.date     "request_date"
    t.integer  "contact_id"
    t.integer  "customer_id"
    t.text     "customer_summary"
    t.integer  "status"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["contact_id"], name: "index_feature_requests_on_contact_id", using: :btree
    t.index ["customer_id"], name: "index_feature_requests_on_customer_id", using: :btree
  end

  create_table "features", force: :cascade do |t|
    t.string   "name"
    t.string   "bug_request"
    t.integer  "status"
    t.integer  "feature_request_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["feature_request_id"], name: "index_features_on_feature_request_id", using: :btree
  end

end
