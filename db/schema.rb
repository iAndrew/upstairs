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

ActiveRecord::Schema.define(:version => 20101118183705) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "group_type"
    t.string   "citation"
    t.string   "citation_author"
    t.string   "aim_of_project"
    t.string   "client"
    t.string   "web_page"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["name"], :name => "index_groups_on_name", :unique => true

  create_table "involvements", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "status"
    t.integer  "role_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "added_by"
    t.string   "edited_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "involvements", ["group_id"], :name => "index_involvements_on_group_id"
  add_index "involvements", ["user_id", "group_id", "role_id"], :name => "index_involvements_on_user_id", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "tech"
    t.string   "role_type"
    t.string   "area"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "user_contacts", :force => true do |t|
    t.string   "category"
    t.string   "value"
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
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
