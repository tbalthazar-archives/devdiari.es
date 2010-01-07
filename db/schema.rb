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

ActiveRecord::Schema.define(:version => 20091226150729) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", :force => true do |t|
    t.integer  "tweet_id",                :limit => 8
    t.integer  "twitterer_id",            :limit => 8
    t.string   "text"
    t.string   "source"
    t.boolean  "truncated"
    t.integer  "in_reply_to_status_id",   :limit => 8
    t.integer  "in_reply_to_user_id",     :limit => 8
    t.boolean  "favorited"
    t.string   "in_reply_to_screen_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweets", ["tweet_id"], :name => "index_tweets_on_tweet_id", :unique => true

  create_table "twitterers", :force => true do |t|
    t.integer  "twitterer_id",         :limit => 8
    t.string   "screen_name"
    t.string   "time_zone"
    t.string   "utc_offset"
    t.string   "profile_image_url"
    t.string   "url"
    t.string   "location"
    t.string   "name"
    t.string   "description"
    t.datetime "twitterer_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                            :default => false
  end

  add_index "twitterers", ["screen_name"], :name => "index_twitterers_on_screen_name", :unique => true
  add_index "twitterers", ["twitterer_id"], :name => "index_twitterers_on_twitterer_id", :unique => true

end
