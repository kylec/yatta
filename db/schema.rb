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

ActiveRecord::Schema.define(:version => 20120617224354) do

  create_table "goals", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "description"
  end

  add_index "goals", ["title"], :name => "index_goals_on_title"

  create_table "milestones", :force => true do |t|
    t.integer  "goal_id"
    t.string   "title"
    t.string   "description"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_goal_comment_relationships", :force => true do |t|
    t.integer  "user_goal_relationship_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_goal_milestone_relationships", :force => true do |t|
    t.integer  "user_goal_relationship_id"
    t.integer  "milestone_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_goal_relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "goal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_goal_relationships", ["goal_id"], :name => "index_user_goal_relationships_on_goal_id"
  add_index "user_goal_relationships", ["user_id", "goal_id"], :name => "index_user_goal_relationships_on_user_id_and_goal_id", :unique => true
  add_index "user_goal_relationships", ["user_id"], :name => "index_user_goal_relationships_on_user_id"

  create_table "user_goal_relationships_comments", :force => true do |t|
    t.integer  "user_goal_relationship_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "username"
    t.string   "profile_picture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
  end

  add_index "users", ["username"], :name => "index_users_on_username"

end
