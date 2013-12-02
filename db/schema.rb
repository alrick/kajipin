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

ActiveRecord::Schema.define(:version => 20131202131955) do

  create_table "avatars", :force => true do |t|
    t.string   "url"
    t.string   "key"
    t.string   "handle"
    t.integer  "size"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "avatars", ["user_id"], :name => "index_avatars_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "value"
    t.integer  "pin_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["pin_id"], :name => "index_comments_on_pin_id"

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "friendships", ["friend_id"], :name => "index_friendships_on_friend_id"
  add_index "friendships", ["user_id"], :name => "index_friendships_on_user_id"

  create_table "heralds", :force => true do |t|
    t.integer  "user_id"
    t.string   "key"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "heralds", ["user_id"], :name => "index_heralds_on_user_id"

  create_table "photos", :force => true do |t|
    t.string   "url"
    t.integer  "pin_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "key"
    t.string   "handle"
    t.integer  "size"
  end

  add_index "photos", ["pin_id"], :name => "index_photos_on_pin_id"

  create_table "pins", :force => true do |t|
    t.string   "title"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "country_name"
    t.string   "country_code"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "ext_id"
    t.integer  "population"
    t.string   "type"
    t.string   "continent_code"
  end

  add_index "pins", ["type"], :name => "index_pins_on_type"
  add_index "pins", ["user_id"], :name => "index_pins_on_user_id"

  create_table "requests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "requester_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "tokens", :force => true do |t|
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "explorer",               :default => false, :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
