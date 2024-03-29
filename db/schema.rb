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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120505034853) do

  create_table "information", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "image"
    t.integer  "supporter_count", :default => 0
    t.string   "hash_tag"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "supporters", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.boolean  "payment",    :default => false
    t.string   "profile_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "screen_name"
    t.string   "image"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
