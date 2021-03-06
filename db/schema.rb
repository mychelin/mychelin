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

ActiveRecord::Schema.define(:version => 20121205084852) do

  create_table "lists", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "lists", ["post_id"], :name => "index_lists_on_post_id"
  add_index "lists", ["user_id"], :name => "index_lists_on_user_id"

  create_table "posts", :force => true do |t|
    t.text     "comment"
    t.binary   "photo"
    t.integer  "star"
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "posts", ["restaurant_id"], :name => "index_posts_on_restaurant_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "restaurants", :force => true do |t|
    t.string   "name",          :null => false
    t.string   "tel"
    t.string   "url"
    t.string   "location",      :null => false
    t.string   "address"
    t.text     "business_hour"
    t.text     "holiday"
    t.integer  "capacity"
    t.boolean  "credit"
    t.boolean  "parking"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name",                          :null => false
    t.string   "email"
    t.string   "provider"
    t.string   "uid",                           :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "role",       :default => "nil"
    t.string   "icon",       :default => "nil"
  end

end
