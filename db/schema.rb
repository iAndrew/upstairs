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

ActiveRecord::Schema.define(:version => 20101026154531) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_contacts", :force => true do |t|
    t.string   "contact_type"
    t.string   "contact_value"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_contacts", ["user_id"], :name => "index_user_contacts_on_user_id"

  create_table "user_interests", :force => true do |t|
    t.string   "interest"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_interests", ["user_id"], :name => "index_user_interests_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "pass"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "second_name"
    t.date     "birth_date"
    t.text     "about_me"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
