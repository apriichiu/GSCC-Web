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

ActiveRecord::Schema.define(:version => 20100909054732) do

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.text     "overview"
    t.text     "theme_verse"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entries", :force => true do |t|
    t.string   "topic"
    t.string   "series"
    t.date     "date"
    t.text     "verse"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.text     "page"
    t.datetime "startdate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
  end

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.integer  "size"
    t.string   "type"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
