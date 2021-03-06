# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130928013153) do

  create_table "attachments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "object_file_name"
    t.string   "object_content_type"
    t.integer  "object_file_size"
    t.datetime "object_updated_at"
    t.integer  "entry_id"
  end

  create_table "entries", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "folder_id"
    t.string   "verse"
    t.datetime "entry_date"
    t.string   "tags"
  end

  create_table "facebook_events", :force => true do |t|
    t.string   "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "location"
    t.text     "description"
    t.datetime "updated_time"
    t.string   "identifier"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "reg",          :default => false
    t.text     "paypal"
  end

  create_table "folders", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "folder_type"
  end

  create_table "registrations", :force => true do |t|
    t.string   "fullname"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.string   "church"
    t.integer  "payment_type"
    t.integer  "paid",                 :default => 0
    t.integer  "guests",               :default => 0
    t.string   "guests_names"
    t.string   "guests_relation"
    t.string   "access_token"
    t.string   "password"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "food_allergies"
    t.boolean  "family_accomodations"
  end

end
