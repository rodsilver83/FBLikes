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

ActiveRecord::Schema.define(:version => 20130620192631) do

  create_table "collection_likes", :force => true do |t|
    t.integer  "id_user"
    t.integer  "id_collection"
    t.string   "collection_name"
    t.string   "collection_slogan"
    t.string   "collection_description"
    t.string   "collection_image"
    t.integer  "like"
    t.integer  "status"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "collections", :force => true do |t|
    t.integer "designer_id"
    t.string  "collection_name"
    t.string  "collection_slogan"
    t.string  "description"
    t.string  "collection_url"
    t.string  "image"
    t.string  "thumb"
    t.integer "profit_margin_id"
    t.date    "offer_starts"
    t.date    "offer_ends"
    t.integer "created_by"
    t.date    "created_at",        :null => false
    t.integer "updated_by"
    t.date    "updated_at",        :null => false
    t.integer "margin_auth"
    t.integer "in_review"
    t.integer "published"
    t.integer "status"
  end

  create_table "users", :force => true do |t|
    t.integer  "fb_id"
    t.string   "fb_token"
    t.string   "fb_name"
    t.string   "fb_gender"
    t.string   "fb_birthday"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
