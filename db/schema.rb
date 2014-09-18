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

ActiveRecord::Schema.define(:version => 20140806144341) do

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.string   "user_name"
    t.integer  "karma"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "post_id"
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "post_daily_lists", :force => true do |t|
    t.text     "items"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "post_favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "post_favorites", ["post_id"], :name => "index_post_favorites_on_post_id"
  add_index "post_favorites", ["user_id"], :name => "index_post_favorites_on_user_id"

  create_table "post_relations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.boolean  "voted"
    t.integer  "comment_count"
    t.text     "voted_comments"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.boolean  "favorited"
  end

  add_index "post_relations", ["post_id"], :name => "index_post_relations_on_post_id"
  add_index "post_relations", ["user_id"], :name => "index_post_relations_on_user_id"

  create_table "post_votes", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "post_votes", ["post_id"], :name => "index_post_votes_on_post_id"
  add_index "post_votes", ["user_id"], :name => "index_post_votes_on_user_id"

  create_table "post_weekly_lists", :force => true do |t|
    t.text     "items"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "user_name"
    t.integer  "karma"
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "user_comment_lists", :force => true do |t|
    t.integer  "user_id"
    t.text     "items"
    t.integer  "low_karma"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_comment_lists", ["user_id"], :name => "index_user_comment_lists_on_user_id"

  create_table "user_favorite_lists", :force => true do |t|
    t.integer  "user_id"
    t.text     "items"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_favorite_lists", ["user_id"], :name => "index_user_favorite_lists_on_user_id"

  create_table "user_post_lists", :force => true do |t|
    t.integer  "user_id"
    t.text     "items"
    t.integer  "low_karma"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_post_lists", ["user_id"], :name => "index_user_post_lists_on_user_id"

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "user_name"
    t.integer  "karma"
    t.string   "about_me"
  end

  add_index "user_profiles", ["user_id"], :name => "index_user_profiles_on_user_id"

  create_table "user_recent_lists", :force => true do |t|
    t.integer  "user_id"
    t.text     "items"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_recent_lists", ["user_id"], :name => "index_user_recent_lists_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "remember_token"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
