# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170116200621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "iban"
    t.integer  "amount",     default: 0
    t.string   "holder"
    t.integer  "bank_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "accounts", ["bank_id"], name: "index_accounts_on_bank_id", using: :btree

  create_table "banks", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "num_of_transfers", default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.string   "sender"
    t.string   "beneficiary"
    t.string   "amount"
    t.string   "status"
    t.string   "transfer_type"
    t.integer  "bank_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "transfers", ["bank_id"], name: "index_transfers_on_bank_id", using: :btree

end
