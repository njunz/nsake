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

ActiveRecord::Schema.define(:version => 20110629113503) do

  create_table "admin_users", :force => true do |t|
    t.string   "first_name",       :default => "",    :null => false
    t.string   "last_name",        :default => "",    :null => false
    t.string   "role",                                :null => false
    t.string   "email",                               :null => false
    t.boolean  "status",           :default => false
    t.string   "token",                               :null => false
    t.string   "salt",                                :null => false
    t.string   "crypted_password",                    :null => false
    t.string   "preferences"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true

  create_table "line_items", :force => true do |t|
    t.integer  "product_id",  :null => false
    t.integer  "order_id",    :null => false
    t.integer  "quantity",    :null => false
    t.integer  "total_price", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "email"
    t.string   "pay_type",       :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_kana"
    t.string   "tel"
    t.string   "zip"
    t.string   "email_confirm"
    t.string   "send_name"
    t.string   "send_name_kana"
    t.string   "send_tel"
    t.string   "send_zip"
    t.text     "send_address"
    t.text     "remark"
    t.boolean  "is_adult"
    t.string   "delivery_date"
    t.string   "time_zone"
  end

  create_table "products", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.string   "cover_image_uid"
    t.string   "cover_image_name"
    t.string   "detail_image_uid"
    t.string   "detail_image_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

end