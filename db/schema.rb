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

ActiveRecord::Schema.define(:version => 20140401065251) do

  create_table "attachments", :force => true do |t|
    t.string   "file_name"
    t.binary   "file_url"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "authorities", :force => true do |t|
    t.string   "user_authority"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "divisors", :force => true do |t|
    t.string   "divisor_name"
    t.integer  "factor_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "queue"
  end

  create_table "evidences", :force => true do |t|
    t.integer  "project_id"
    t.integer  "test_file_id"
    t.integer  "example_id"
    t.integer  "evidence_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "examples", :force => true do |t|
    t.string   "content"
    t.string   "status"
    t.string   "affirm"
    t.string   "result"
    t.date     "implement_time"
    t.string   "implement_people"
    t.string   "remark"
    t.date     "again_implement_time"
    t.string   "again_implement_people"
    t.integer  "test_file_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "factors", :force => true do |t|
    t.string   "factor_name"
    t.integer  "test_file_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "queue"
  end

  create_table "groups", :force => true do |t|
    t.string   "group_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "project_name"
    t.string   "description"
    t.string   "test_file_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "work_year"
    t.string   "identifer"
    t.integer  "group_id"
  end

  create_table "rules", :force => true do |t|
    t.string   "content"
    t.integer  "test_file_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "test_files", :force => true do |t|
    t.string   "test_file_name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "project_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.integer  "authority_id", :default => 3
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "versions", :force => true do |t|
    t.string   "work_year"
    t.string   "identifer"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
