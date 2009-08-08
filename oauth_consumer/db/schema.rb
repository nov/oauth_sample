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

ActiveRecord::Schema.define(:version => 3) do

  create_table "oauth_access_tokens", :force => true do |t|
    t.integer  "user_id"
    t.integer  "oauth_consumer_id"
    t.string   "token",             :limit => 1024, :null => false
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oauth_consumers", :force => true do |t|
    t.string   "service_provider"
    t.string   "consumer_key"
    t.string   "consumer_secret"
    t.string   "scope"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
